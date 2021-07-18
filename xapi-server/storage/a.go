package main

import (
	"log"
	"os/exec"
)

func main() {
	cmd := exec.Command("swag" ,"init")
	cmd.Run()
	if _, err := cmd.StdoutPipe(); err != nil { //获取输出对象，可以从该对象中读取输出结果

		log.Fatal(err)

	}
}
