Return-Path: kzak@redhat.com
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [PATCH 00/49] login refactoring
Date: Mon, 17 Oct 2011 13:14:39 +0200
Message-Id: <1318850128-23458-1-git-send-email-kzak@redhat.com>
In-Reply-To: <20111017110210.GA22648@nb.net.home>
References: <20111017110210.GA22648@nb.net.home>
List-ID: <util-linux.vger.kernel.org>

git://github.com/karelzak/util-linux.git login

Karel Zak (49):
  login: remove kerberos specific code
  login: remove dead code and comments
  login: move _PATH_BTMP to pathnames.h
  login: remove non-PAM code
  build-sys: require PAM for login-utils
  login: remove PAM_FAIL_CHECK and PAM_END macros
  lib: cleanup setproctitle.c
  login: cleanup begin of the login.c file
  login: remove obsolete code, clean up macros names
  login: indent -linux
  login: add struct login_context, consolidate tty code
  login: add hostname to login_context struct
  login: add pid to login_context struct
  login: add username to login_context struct
  login: use login_context struct in audit stuff
  login: lastlog code refactoring
  login: utmp code refactoring
  login: use getpwnam_r() rather than manually copy passwd struct
  login: tty chown.chmod refactoring
  login: use setgroups(0, NULL) for root
  login: improve hushed mode (merge suse changes)
  login: remove unused code and tests
  login: PAM initialization refactoring
  login: PAM auth refactoring
  login: PAM account checks refactoring
  login: PAM session initialization refactoring
  login: remove pam_handle_t from main()
  login: fork & session initialization refactoring
  login: env initialization refactoring
  login: use xalloc.h
  login: log good logins refactoring
  login: move signal stuff to the one place
  login: remove unnecessary variables
  login: host{name,address} initialization refactoring
  tests: cleanup islocal test
  login: add login.defs code and tests
  tests: remove obsolete checktty test
  login: remove obsolete info from man page
  login: rewrite motd(), use MOTD_FILE from login.defs
  login: use LOGIN_TIMEOUT from login.defs
  login: use FAIL_DELAY from login.defs
  login: use TTYPERM from login.defs
  login:  use TTYGROUP from login.defs
  login:  use HUSHLOGIN_FILE from login.defs
  login: use DEFAULT_HOME from login.defs
  login: use LOG_UNKFAIL_ENAB from login.defs, improve logging
  login: add -H option for compatibility with Suse
  login: use ENV_PATH and ENV_{ROOT,SU}PATH from login.defs
  login: cosmetic changes in docs

 configure.ac                   |   16 +-
 include/pathnames.h            |    7 +
 include/setproctitle.h         |   10 +-
 lib/setproctitle.c             |   75 +-
 login-utils/.gitignore         |    4 +-
 login-utils/Makefile.am        |   20 +-
 login-utils/checktty.c         |  585 ----------
 login-utils/islocal.c          |    6 +-
 login-utils/login.1            |  375 +++----
 login-utils/login.c            | 2413 +++++++++++++++++++---------------------
 login-utils/login.h            |    9 -
 login-utils/logindefs.c        |  246 ++++
 login-utils/logindefs.h        |    9 +
 tests/commands.sh.in           |    5 +-
 tests/expected/login/checktty  |    8 -
 tests/expected/login/logindefs |   14 +
 tests/ts/login/checktty        |   26 -
 tests/ts/login/islocal         |    2 +-
 tests/ts/login/logindefs       |   24 +
 tests/ts/login/logindefs.data  |   16 +
 20 files changed, 1676 insertions(+), 2194 deletions(-)
 delete mode 100644 login-utils/checktty.c
 delete mode 100644 login-utils/login.h
 create mode 100644 login-utils/logindefs.c
 create mode 100644 login-utils/logindefs.h
 delete mode 100644 tests/expected/login/checktty
 create mode 100644 tests/expected/login/logindefs
 delete mode 100755 tests/ts/login/checktty
 create mode 100755 tests/ts/login/logindefs
 create mode 100644 tests/ts/login/logindefs.data

-- 
1.7.6.4
