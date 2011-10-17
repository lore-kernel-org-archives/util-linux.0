Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:10744 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755308Ab1JQLCP (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 17 Oct 2011 07:02:15 -0400
Date: Mon, 17 Oct 2011 13:02:11 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Ludwig Nussel <ludwig.nussel@suse.de>, Thorsten Kukuk <kukuk@suse.de>
Subject: login: PAM-only, login.defs, -H
Message-ID: <20111017110210.GA22648@nb.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 I did some changes to login(1) in last weeks. The goal is to have one PAM-only
 login(1) for all mainstream distributions. 

 The code is based on the original util-linux login(1) and pam_login-4.0
 package from Suse.

 Git tree: https://karelzak@github.com/karelzak/util-linux.git branch 'login'.
 URL: https://github.com/karelzak/util-linux/tree/login

 Changes:

 - remove kerberos specific code
 - remove non-PAM code
 - remove checktty stuff
 - remove ugly macros (e.g. PAM_END)
 - add syslog LOG_ERR on failed tty ch{mod,own} (based on Suse version)
 - move all important/global variables to 'struct login_context'
 - indent to Linux coding style
 - use xalloc.h functions
 - lastlog, utmp, btmp, audit and syslog code refactoring

 - don't log unknown usernames to system log files (may be a security issue if
   an user enter her password instead of her login name) -- controlled by
   LOG_UNKFAIL_ENAB login.defs variable

 - support /etc/login.defs, supported variables:

     name               default
     ------------------------------
     DEFAULT_HOME       yes (means chdir("/") if pwd->pw_dir does not exist)  
     ENV_PATH           "/usr/local/bin:/bin:/usr/bin"
     ENV_{ROOT,SU}PATH  "/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin"
     FAIL_DELAY		5s
     HUSHLOGIN_FILE     /etc/hushlogins and ~/.hushlog
     LOGIN_TIMEOUT      60s
     LOG_UNKFAIL_ENAB	yes
     MOTD_FILE          /etc/motd
     TTYGROUP           'tty' (otherwise pwd->pw_gid is used)
     TTYPERM            0620 (or 0600 for --disable-use-tty-group)
    
   Note that Suse version does not use any defaults for *_FILE and TTYGROUP.

 - print hostname in the login prompt, for example:

     "foo login: "

   Note that Suse version uses hostname with domain (e.g. foo.example.com), our
   goal is to be compatible with the default agetty behavior. 
  
 - add new -H option to suppress hostname in the login prompt (already in Suse
   version)
   
 - call setgroups(0, NULL) rather than initgroups() for root user
   (this avoids the need to step through the whole group file, which can cause
    problems if NIS, NIS+, LDAP or something similar is used and the machine 
    has network problems)

 - improve hushed mode (moslty based on Suse version)
   * accepts HUSHLOGIN_FILE from /etc/login.defs
   * empty /etc/hushlogins file enables hushed mode for all accounts
     (this new feature is necessary if you want to use PAM for motd and last 
      login messages)

 Comments?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
