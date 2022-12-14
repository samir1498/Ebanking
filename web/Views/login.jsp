<%-- 
    Document   : login
    Created on : 17 juin 2022, 21:12:32
    Author     : Samir
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="../includes/taglibs.jsp"%>
<fmt:bundle basename="configuration.application">
  <fmt:message key="BankName" var="BankName" scope="session" />
  <fmt:message key="password" var="checkPasswordLogin" scope="session" />
  <fmt:message key="Code-unique" var="checkuniqueCodeLogin" scope="session" />
</fmt:bundle>
<c:if test="${langue !=null}">
  <fmt:setLocale value="${langue}"></fmt:setLocale>
</c:if>
<!doctype html>
<html>

  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <fmt:bundle basename="i18n.Bundle">
      <title><fmt:message key="title.login" /></title>
    </fmt:bundle>

    <link rel="stylesheet" href="css/navbar-style.css">
    <link rel="stylesheet" href="css/login-style.css">
    <link rel="stylesheet" href="fontawsome/css/all.css">
    <script src="js/jquery/jquery-3.6.0.min.js"></script>
    <script src="js/jquery/jquery.cookie.js"></script>


    <c:if test="${langue == 'ar'}">
      <style>
        *{
          direction: rtl;
        }
        .toggle-button{
          left: 1rem;
          right: auto
        }
      </style>
    </c:if>

  </head>

  <body>
    <c:if test="${langue !=null}">
      <fmt:setLocale value="${langue}"></fmt:setLocale>
    </c:if>
    <fmt:bundle basename="i18n.Bundle">
      <nav class="navbar">


        <div class="brand-title">
          <a href="Home">
            <i class="fa-solid fa-building-columns"></i>
            <label> ${BankName} </label>
          </a>
        </div>

        <a href="#" class="toggle-button">
          <span class="bar"></span>
          <span class="bar"></span>
          <span class="bar"></span>
        </a>
        <div class="navbar-links">
          <ul>
            <li><a href="Home"><fmt:message key="navbar.home"/></a></li>
            <li><a href="Register"><fmt:message key="navbar.register"/></a></li>
              <c:if test="${langues.size()!=1 and langues.size()!=0}">
              <li>
                <form action="LanguageChangerServlet" method="post" id="lang">
                  <select id="lang_select" name="language_list" onchange="submitform()">
                    <c:forEach  items="${langues}" var="lang">
                      <option value="${lang}"><fmt:message key="lang.${lang}"/></option>
                    </c:forEach>
                  </select>
                </form>
              </li>
            </c:if>
          </ul>
        </div>
      </nav>
      <c:if test = "${checkPasswordLogin =='true'}">
        <div class="login-form-container">

          <form action="Login" method="post">
            <h1><fmt:message key="title.login" /></h1>
            <table>

              <tr>
                <td><i class="fa-solid fa-user"></i><input id="username" type="text" name="username" placeholder="<fmt:message key="placeholder.username" />" required autofocus></td>
              </tr>
              <tr>
                <td><i class="fa-solid fa-lock"></i><input id="password" type="password" name="pass" placeholder="<fmt:message key="placeholder.password" />" required ></td>
              </tr>
              <c:if test="${login_error !=null}">
                <tr>
                  <td colspan="2">
                    <span class="error" style="display: block" ><fmt:message key="${login_error}"/></span>
                  </td>
                </tr>
              </c:if>

              <tr>
                <td><input type="submit" value="<fmt:message key="submit.login"/>"></td>
              </tr>
              <tr>
                <td><a href="ResetPassword"><fmt:message key="ancher.forgot_password"/></a></td>
              </tr>
            </table>

          </form>


        </div>

      </c:if>
              <!-- Code Login -->
      <c:if test="${checkuniqueCodeLogin == 'true'}">
        <div class="login-form-container code">

          <form action="Login" method="post">
            <h1><fmt:message key="title.login" /></h1>
            <table>
              <tr>
                <td><i class="fa-solid fa-lock"></i>
                  <input id="code" type="text" name="code" placeholder="<fmt:message key="placeholder.code" />" required >
                </td>
              </tr>
              <c:if test="${login_error !=null}">
                <tr>
                  <td colspan="2">
                    <span class="error" style="display: block" ><fmt:message key="${login_error}"/></span>
                  </td>
                </tr>
              </c:if>

              <tr>
                <td><input type="submit" value="<fmt:message key="submit.login"/>"></td>
              </tr>

            </table>

          </form>


        </div>
      </c:if>

      <script>
        const toggleButton = document.getElementsByClassName('toggle-button')[0];
        const navbarLinks = document.getElementsByClassName('navbar-links')[0];

        toggleButton.addEventListener('click', () => {
          navbarLinks.classList.toggle('active');
        });
        function submitform() {
          $('#lang').submit();
        }
        $(document).ready(function () {

          var langue = '${langue}';
          $('#lang_select').val(langue);
          $.cookie('langue', langue, {path: '/'});
          $('#lang_select').val(langue);

          $.removeCookie('active_popup', {path: '/'});
          $.removeCookie("transfer_error", {path: '/'});
          localStorage.clear();
        });

      </script>


    </fmt:bundle>
  </body>

</html>
