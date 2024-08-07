/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.model;

/**
 *
 * @author kat1002
 */
public class Manager {

    private int managerId;
    private String username;
    private String phone_number;
    private String email;
    private String first_name;
    private String last_name;
    private int role;

    public Manager() {
    }

    public Manager(int managerId, String username, String phone_number, String email, String first_name, String last_name, int role) {
        this.managerId = managerId;
        this.username = username;
        this.phone_number = phone_number;
        this.email = email;
        this.first_name = first_name;
        this.last_name = last_name;
        this.role = role;
    }

    public Manager(String username, String phone_number, String email, String first_name, String last_name, int role) {
        this.username = username;
        this.phone_number = phone_number;
        this.email = email;
        this.first_name = first_name;
        this.last_name = last_name;
        this.role = role;
    }

    public Manager(int managerId, int role, String firstName, String lastName, String email, String phoneNumber) {
        this.managerId = managerId;
        this.role = role;
        this.first_name = firstName;
        this.last_name = lastName;
        this.email = email;
        this.phone_number = phoneNumber;
    }

    public String getRoleName(){
        if(role == 1 ) return "Manager";
        if(role == 2) return "Sale Staff";
        if(role == 3) return "Customer Service Staff";
        return "all";
    }

    public int getRole(){
        return role;
    }

    public int getManagerId() {
        return managerId;
    }

    public void setRole(int role) {
        this.role = role;
    }

    public void setManagerId(int managerId) {
        this.managerId = managerId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPhone_number() {
        return phone_number;
    }

    public void setPhone_number(String phone_number) {
        this.phone_number = phone_number;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFirst_name() {
        return first_name;
    }

    public void setFirst_name(String first_name) {
        this.first_name = first_name;
    }

    public String getLast_name() {
        return last_name;
    }

    public void setLast_name(String last_name) {
        this.last_name = last_name;
    }

    @Override
    public String toString() {
        return "Manager{" + "managerId=" + managerId + ", username=" + username + ", phone_number=" + phone_number + ", email=" + email + ", first_name=" + first_name + ", last_name=" + last_name + ", role=" + getRole() + "}";
    }

}
