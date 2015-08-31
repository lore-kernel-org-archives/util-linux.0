Return-Path: util-linux-owner@vger.kernel.org
Received: from mail1.windriver.com ([147.11.146.13]:43897 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752940AbbHaIcz (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 31 Aug 2015 04:32:55 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id t7V8Ws6R015319
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <util-linux@vger.kernel.org>; Mon, 31 Aug 2015 01:32:55 -0700 (PDT)
From: Chen Qi <Qi.Chen@windriver.com>
To: <util-linux@vger.kernel.org>
Subject: include errno.h instead of argp.h
Date: Mon, 31 Aug 2015 16:23:45 +0800
Message-ID: <1441009426-13799-2-git-send-email-Qi.Chen@windriver.com>
In-Reply-To: <1441009426-13799-1-git-send-email-Qi.Chen@windriver.com>
References: <1441009426-13799-1-git-send-email-Qi.Chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

configure should include errno.h instead of argp.h when
checking for presence of program_invocation_short_name
uclibc defines this to be const char* unlike util-linux-ng
which defines this to be char* so this error goes unnoticed
on glibc/eglibc systems.

here is the error it fixes

in file included from mountP.h:14:0,                                                                               
                 from cache.c:29:                                                                                  
/home/kraj/work/slugos/build/tmp-slugos-uclibc/sysroots/nslu2le/usr/include/errno.h:55:46: error: conflicting types for '__progname'                                                                                                  
../../../include/c.h:118:14: note: previous declaration of '__progname' was here                                   
make[3]: *** [cache.lo] Error 1          


Signed-off-by: Khem Raj <raj.khem@gmail.com>
Signed-off-by: Jonathan Liu <net147@gmail.com>

Index: util-linux-2.22.1/configure.ac
===================================================================
--- util-linux-2.22.1.orig/configure.ac
+++ util-linux-2.22.1/configure.ac
@@ -372,7 +372,7 @@ esac
 
 AC_MSG_CHECKING([whether program_invocation_short_name is defined])
 AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
-	#include <argp.h>
+	#include <errno.h>
 ]], [[
 	program_invocation_short_name = "test";
 ]])], [
