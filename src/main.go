package main

import (
	"fmt"
	"net/http"
	"os"
)

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func main() {
	http.HandleFunc("/", HelloServer)
	http.ListenAndServe(":8080", nil)
}

func HelloServer(w http.ResponseWriter, r *http.Request) {
	fmt.Println(r)
	hello, err := os.ReadFile("/etc/watcher/data.txt")
	check(err)
	data := r.URL.Path[1:]
	_, err = fmt.Fprintf(w, "%s %s!", hello, data)
	check(err)
	err = os.WriteFile("/etc/watcher/tmp/tmp.txt", []byte(data), 0660)
	check(err)

}
