Return-Path: util-linux-owner@vger.kernel.org
Received: from frodol.xs4all.nl ([212.238.236.230]:50680 "EHLO
	morannon.frodo.site" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753679AbaKXOXb (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 24 Nov 2014 09:23:31 -0500
Received: from forochel.frodo.site (a80-127-247-41.mobile.xs4all.nl [80.127.247.41])
	by morannon.frodo.site (8.14.4/8.14.4/Debian-4) with ESMTP id sAOEAPXR004985
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Mon, 24 Nov 2014 15:10:29 +0100
Received: from forochel.frodo.site (localhost [127.0.0.1])
	by forochel.frodo.site (8.14.4/8.14.4/Debian-4) with ESMTP id sAOEAMjW031917
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <util-linux@vger.kernel.org>; Mon, 24 Nov 2014 15:10:23 +0100
Received: (from frodo@localhost)
	by forochel.frodo.site (8.14.4/8.14.4/Submit) id sAOEALC2031916
	for util-linux@vger.kernel.org; Mon, 24 Nov 2014 15:10:21 +0100
Date: Mon, 24 Nov 2014 15:10:21 +0100
From: Frodo Looijaard <frodo@frodo.looijaard.name>
To: util-linux@vger.kernel.org
Subject: Getopt 1.1.6 released
Message-ID: <20141124141021.GA29970@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi all,

I just released version 1.1.6 of getopt. It can be downloaded from
http://frodo.looijaard.name/project/getopt . A subversion repository 
is available at svn://svn.frodo.looijaard.name/public/getopt .

>From the release notes:

Major bug fixes in this version:
  * Properly quote backslashes for tcsh
  * Detect ambiguous long options properly (thanks to Klaus Wulff <dinw.klswlff@dfgh.net>)
Other changes:
  * Create test harness and tests
  * Sync with util-linux (git 20141120)): translations, manual page and code

Note that there are (still) a few slight changes between these getopt sources
and the util-linux version in getopt.c:
  * Includes are slightly different
  * Util-linux has removed a free(BUFFER) and added an atexit(close_stdout)
    call.
Please be aware of this when merging the other changes.

Kind regards,
  Frodo Looijaard (getopt author)

-- 
Frodo Looijaard <frodo@frodo.looijaard.name> (See http://frodo.looijaard.name/)
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.
