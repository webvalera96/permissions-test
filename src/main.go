package main

import (
	"fmt"
	"io"
	"net/http"
	"os"
	"time"
)

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func main() {
	go ReadCmAndWriteToLogs(100 * time.Millisecond)
	http.HandleFunc("/", HelloServer)
	http.ListenAndServe(":8080", nil)
}

func HelloServer(w http.ResponseWriter, r *http.Request) {
	hello, err := os.ReadFile("/etc/watcher/data.txt")
	check(err)
	data := r.URL.Path[1:]
	_, err = fmt.Fprintf(w, "%s %s!", hello, data)
	check(err)
	err = os.WriteFile("/etc/watcher/tmp/tmp.txt", []byte(data), 0660)
	check(err)

}

func ReadCmAndWriteToLogs(timeout time.Duration) {
	for {
		cm256info, err := os.ReadFile("/etc/watcher/data/cm-256/info")
		check(err)
		cm288info, err := os.ReadFile("/etc/watcher/data/cm-288/info")
		check(err)

		//logFile, err := os.OpenFile("/etc/watcher/tmp/log.txt", os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)
		t := time.Now()
		logcm256 := fmt.Sprintf("--log-- [%s] %s\n\n", t.Format(time.RFC3339Nano), cm256info)
		time.Sleep(timeout)
		//_, err = logFile.WriteString(logcm256)
		_, err = io.WriteString(os.Stdout, logcm256)
		check(err)
		t = time.Now()
		logcm288 := fmt.Sprintf("--log-- [%s] %s\n\n", t.Format(time.RFC3339Nano), cm288info)
		//_, err = logFile.WriteString(logcm288)
		_, err = io.WriteString(os.Stdout, logcm288)
		check(err)
		time.Sleep(timeout)
	}
}
