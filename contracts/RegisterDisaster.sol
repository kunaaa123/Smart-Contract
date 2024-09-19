// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract RegisterDisaster {
    address public owner; // เก็บข้อมูลของเจ้าของ Smart Contract (ใช้ใน Constructor)

    struct Person {
        string idCard; // รหัสบัตรประชาชน
        string firstName; // ชื่อ
        string lastName; // นามสกุล
        string addr; // ที่อยู่
    }

    Person[] private people; // สร้างตัวแปรอาเรย์ของประเภท Person เพื่อเก็บข้อมูลผู้คนที่จะลงทะเบียน
    mapping(string => uint256) private idToIndex; // สร้างตัวแปรแมพของประเภท uint256 เพื่อเก็บข้อมูลดัชนีของผู้คนตามรหัสบัตรประชาชน

    // constructor คือฟังก์ชันที่จะถูกเรียกใช้งานเมื่อมีการสร้างอินสแตนซ์ของ Smart Contract
    constructor() {
        owner = msg.sender; // กำหนดผู้ที่สร้างสัญญาเป็นเจ้าของ
    }

    // ฟังก์ชันสำหรับลงทะเบียนผู้เข้าร่วม
    function registerPerson(
        string memory _idCard,
        string memory _firstName,
        string memory _lastName,
        string memory _address
    ) public {
        require(idToIndex[_idCard] == 0, "Person is already registered"); // ตรวจสอบว่ามีการลงทะเบียนหรือยัง
        people.push(Person(_idCard, _firstName, _lastName, _address)); // เพิ่มผู้เข้าร่วมใหม่ในอาเรย์ people
        idToIndex[_idCard] = people.length; // บันทึกดัชนีของผู้เข้าร่วมใน mapping idToIndex
    }

    // ฟังก์ชันสำหรับขอข้อมูลผู้เข้าร่วมทั้งหมด
    function getAll() public view returns (Person[] memory) {
        return people;
    }

    // ฟังก์ชันสำหรับขอข้อมูลผู้เข้าร่วมที่มี index ที่กำหนด
    function getPerson(uint256 index) public view returns (Person memory) {
        require(index < people.length, "Index out of range"); // ตรวจสอบ index ว่ามีในอาเรย์หรือไม่
        return people[index];
    }

    // ฟังก์ชันสำหรับขอข้อมูลผู้เข้าร่วมที่มี idCard ที่กำหนด
    function getID(string memory _idCard) public view returns (Person memory) {
        uint256 index = idToIndex[_idCard];
        require(index != 0, "Person not found"); // ตรวจสอบว่าผู้เข้าร่วมถูกลงทะเบียนหรือไม่
        return people[index - 1]; // index - 1 เพราะ idToIndex เริ่มจาก 1 แต่อาเรย์เริ่มที่ 0
    }
}
