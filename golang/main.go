package main

import (
	"crypto/cipher"
	"crypto/des"
	"crypto/md5"
	"encoding/base64"
	"fmt"
	"io"
	"io/ioutil"

	"github.com/wumansgy/goEncrypt"
)

const personalId string = "A123456789"
const salaryMhtFileName string = "salary.mht"
const salaryEncFileName string = "salary.enc"

func main() {
	// var sKey string = get8LengthString(personalId)

	encryptFile()
	// decryptFile(sKey)
}

func encryptFile() {
	plaintext, err := ioutil.ReadFile(salaryMhtFileName)
	if err != nil {
		fmt.Printf("File not found, %s\n", err)
	} else {
		fmt.Printf("%s data type: %T\n", salaryMhtFileName, plaintext)
	}
	fmt.Printf("----- 明文為 -----\n%s\n", string(plaintext)[:75])

	cryptText, err := goEncrypt.DesCbcEncrypt(plaintext, []byte("a74f3827"), []byte("a74f3827"))
	if err != nil {
		fmt.Println(err)
	}
	fmt.Printf(string(cryptText)[:50])
	fmt.Printf("----- DES 的 CBC 模式加密後的密文為 -----\n%s", base64.StdEncoding.EncodeToString(cryptText)[:50])
}

func decryptFile(sKey string) {
	// .enc file is in Base64, file readed as byte array, no convert needed.
	salaryFileInByte, err := ioutil.ReadFile(salaryEncFileName)
	if err != nil {
		fmt.Printf("File not found, %s\n", err)
	} else {
		fmt.Printf("%s data type: %T\n", salaryEncFileName, salaryFileInByte)
	}
	fmt.Printf("%s", salaryFileInByte[:100])

	// Encoding.ASCII.GetBytes
	key := []byte(sKey)
	IV := []byte(sKey)
	fmt.Printf("Data type of key %T\n", key)
	fmt.Printf("Data type of IV %T\n", IV)
	fmt.Println(key)
	fmt.Println(IV)

	// --- RANDOM BULLSHIT ---
	// 传入密文和自己定义的密钥，需要和加密的密钥一样，不一样会报错，8字节 如果解密秘钥错误解密后的明文会为空
	newplaintext, err := goEncrypt.DesCbcDecrypt(salaryFileInByte, []byte("a74f3827"), []byte("a74f3827")) //解密得到密文,可以自己传入初始化向量,如果不传就使用默认的初始化向量,8字节
	if err != nil {
		fmt.Println(err)
	}

	fmt.Println("DES的CBC模式解密完：", string(newplaintext)[:50])
	// ---RANDOM BULLSHIT ---

	// DES decrypt, mode: CBC, padding: PKCS7
	block, err := des.NewCipher(key)

	if err != nil {
		fmt.Printf("%s", err)
	}

	blockMode := cipher.NewCBCDecrypter(block, IV)
	origData := make([]byte, len(salaryFileInByte))
	blockMode.CryptBlocks(origData, salaryFileInByte)
	origData = PKCS7UnPadding(origData)
	fmt.Printf("%T\n", origData)

	// This line should print out mht file content
	fmt.Printf("%s\n", string(origData)[:87])
	// ioutil.WriteFile("tempAlertReader.mht", origData, 0644)
}

func get8LengthString(id string) string {
	sKey := md5.New()
	io.WriteString(sKey, id)
	md5ToString := fmt.Sprintf("%x", sKey.Sum(nil))
	fmt.Printf("%s, return \"%s\"\n", md5ToString, md5ToString[:8])
	return md5ToString[:8]
}

func PKCS7UnPadding(src []byte) []byte {
	length := len(src)
	unpadding := int(src[length-1])
	return src[:(length - unpadding)]
}
