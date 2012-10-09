Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:43725 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754686Ab2JIXaD (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 9 Oct 2012 19:30:03 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1TLjFU-0008GK-2H
	for util-linux@vger.kernel.org; Wed, 10 Oct 2012 01:30:04 +0200
Received: from 95.64.105.131 ([95.64.105.131])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Wed, 10 Oct 2012 01:30:04 +0200
Received: from terminatorul by 95.64.105.131 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Wed, 10 Oct 2012 01:30:04 +0200
To: util-linux@vger.kernel.org
From: Timothy Madden <terminatorul@gmail.com>
Subject: `mount` command and POSIX Utility Syntax Guidelines
Date: Wed, 10 Oct 2012 02:28:06 +0300
Message-ID: <k52bu0$1up$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

I have the little annoying problem that I can not mount a DAV folder 
with the davfs2 filesystem, because I usually keep POSIXLY_CORRECT 
environment variable set. The var allows me to keep an "aliases" file 
(similar to ~/.basrc) and change it when needed if I put the file name 
in the ENV variable.

The problem is with the invocation of the mount helper command. `mount` 
will compose a command line like this:
    /sbin/mount.davfs \
           https://storage-file-eu.gmx.com/ \
           ./gmx-file-storage \
           -o rw,nosuid,nodev,noauto,user,_netdev,exec
where the option arguments ("-o rw,...") follow the operands (device, 
mount point) on the command line.

However GNU getopts() (from glibc) follows POSIX Utility Syntax 
Guidelines in this case and expects the option arguments before the 
operands.

Subsequently the mount command returns and error when mounting my DAV
folders. I am currently using a wrapper executable around mount.davfs 
that changes the order of arguments on the command line to make it work.

I hope mount command composes such a command line for historical reasons 
and that there are no hidden problems with the order of the options on 
the command line for mount helpers.

Is it please possible for mount command to be updated to change the 
order of arguments on the command line, so that it follows the POSIX 
guidelines ? At least when POSIXLY_CORRECT is set in the environment ?

I have "mount from util-linux 2.21.2 (with libblkid support)" on 
Slackware 13.37 32-bit updated with Slackware-current packages. Also 
happens on up-to-date CentOS 6.3 64-bit with updates from centosplus 
repository, that is "mount from util-linux-ng 2.17.2 (with libblkid and 
selinux support)".


See also the mount.davfs issue report at
      http://savannah.nongnu.org/support/?108145
or the issue reported on Slackware list at:
      http://comments.gmane.org/gmane.linux.slackware/4084

Thank you,
Timothy Madden

