/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.login.dao;

import com.login.bean.LoginBean;
import connexion.util.SingletonConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Samir
 */
public class LoginDaoImpl implements LoginDao {

  static Connection connexion = SingletonConnection.getConnection();
  String passwordAuthentificationQuery = "SELECT * FROM public.client where username=? and passwordclient=?";
  String codeAuthentificationQuery = "SELECT * FROM public.client where codeclient= ?";

  @Override
  public String authenticateUser(LoginBean login) {

    String userName = login.getUsername();
    String password = login.getPassword();

    try {

      PreparedStatement preparedStatement = connexion.prepareStatement(passwordAuthentificationQuery);
      preparedStatement.setString(1, userName);
      preparedStatement.setString(2, password);

      ResultSet rs = preparedStatement.executeQuery();

      if (rs.next()) {
        return rs.getString("ClientState");
      }
    } catch (SQLException ex) {
      Logger.getLogger(LoginDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
    }
    return "error.login";
  }

  @Override
  public String authenticateUserByCode(String code) {

    try {

      PreparedStatement preparedStatement = connexion.prepareStatement(passwordAuthentificationQuery);
      preparedStatement.setString(1, code);

      ResultSet rs = preparedStatement.executeQuery();

      if (rs.next()) {
        if(rs.getString("ClientState").equals("active")){
          return rs.getString("id");
        }
        return rs.getString("ClientState");
      }
    } catch (SQLException ex) {
      Logger.getLogger(LoginDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
    }
    return "error.login";
  }
}
