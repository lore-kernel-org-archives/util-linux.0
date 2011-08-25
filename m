Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-gy0-f174.google.com ([209.85.160.174]:40211 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550Ab1HYMd5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 25 Aug 2011 08:33:57 -0400
Received: by gya6 with SMTP id 6so1696858gya.19
        for <util-linux@vger.kernel.org>; Thu, 25 Aug 2011 05:33:57 -0700 (PDT)
MIME-Version: 1.0
From: Pierre Gaston <pierre.gaston@gmail.com>
Date: Thu, 25 Aug 2011 15:26:14 +0300
Message-ID: <CAPSX3sTRT7zOZALF2CHUdgRuz3Gz4PyXtxmDB6nhVa7VwK7RDQ@mail.gmail.com>
Subject: example in flock manpage still not useful.
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I can see why the following change has been made but, as it is, it
doesn't work at all

http://git.kernel.org/?p=utils/util-linux/util-linux.git;a=commitdiff;h=c348d9346ae60b78a03d6dcd964e23fb40a625df

(
   flock -n 9
   # ... commands executed under lock ...

) 9>/var/lock/mylockfile\fP

flock -n 9 does nothing here besides testing the lock.

I suggest to revert to flock -s 9...or rather to just flock 9, since a
shared lock doesn't indeed seems very useful either here.

The example can be fixed using {   ;} instead of a subshell and adding
flock -n 9 || exit 1, but I think it doesn't match
the intention of the committer which was to show a way to avoid 2
concurrent executions of a script.

If  you want an example exiting the script, I suggest adding an example like:

exec 9>/var/lock/mylockfile  # open the file descriptor for the
duration of the script
flock -n 9 || exit 1                 # exit if the lock can't be acquire.

Pierre
