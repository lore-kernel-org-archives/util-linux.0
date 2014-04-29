Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45174 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933668AbaD2Kqx (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 29 Apr 2014 06:46:53 -0400
Date: Tue, 29 Apr 2014 12:46:40 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>,
        =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>
Subject: terminal-colors.d and termname
Message-ID: <20140429104640.GC24681@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 Hi,

 I'd like to support terminal names ($TERM) in terminal-colors.d,
 because the current implementation does not care about terminal
 types, so you can disable/enable the colors only globally for all
 terminals. That's stupid, because xterm-256color is not the 
 same thing as vt100, etc.

 possible ways:

 1) add terminal name to the file names, for example

    touch terminal-colors.d/dmesg@vt100.disable

 The disadvantage is that there is huge number of terminals and 
 this concept does not allow to use patterns (e.g. fnmatch() patterns 
 like xterm-*). But I think the patterns are unnecessary, because people
 usually use very small set of terminals (serial line, ssh, xterm), so 
 force users to use whole terminal names is no so big problem.

 The advantage is the we can use this concept for color schemes and
 support symlinks to reuse the same scheme for a different terminals.
 The nice things is also that one readdir() is enough to get whole
 configuration.

   echo "error red standard" > dmesg@xterm.scheme
   ln -s dmesg@xterm.scheme dmesg@linux.scheme

 2) use sub-directory

    /etc/terminal-colors/<termname>/dmesg.disable

 but it's less readable (you need "ls -R" or "find") and use symlinks
 will be nightmare.


 3) store the terminal names (or patterns) to the files

    echo "TERM vt10*" >> dmesg.disable

 The same way uses coreutils DIR_COLORS. This concept means that we
 have to always parse the files and you cannot easily create two
 independent color schemes for the same util as there is only one
 'dmesg.scheme', so we will need more advanced file format with
 multiple sections, etc.

 4) ?


 I prefer 1) because it's KISS concept and we have a chance to see
 this way supported by another projects too.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
