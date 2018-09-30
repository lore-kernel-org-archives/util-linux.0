Return-Path: util-linux-owner@vger.kernel.org
Received: from ishtar.tlinx.org ([173.164.175.65]:38696 "EHLO
        Ishtar.sc.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbeJAGIQ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 1 Oct 2018 02:08:16 -0400
Message-ID: <5BB15D3A.8040507@tlinx.org>
Date: Sun, 30 Sep 2018 16:33:14 -0700
From: L A Walsh <lkml@tlinx.org>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.33-rc1
References: <20180925104701.y2gwtwe2bquynap2@ws.net.home>
In-Reply-To: <20180925104701.y2gwtwe2bquynap2@ws.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 9/25/2018 3:47 AM, Karel Zak wrote:
> The commands mount and umount
---
   I note that umount has a static option umount.static, but I don't see
the same for mount (i.e. mount.static). 

  It seems the main benefit of static is to ensure the command will run
if there is a problem with runtime-linking or if libraries are missing. 

  Examples might be a root FS that may have significantly reduced
content but enough to do FS restore operations, emergency repairs and
load kernel modules that will allow one to bring up rest of the system.

  Basic functionality would include ability to mount file systems and
ideally format, manage partitions, and restore file systems from
backups.

  Some utilites necessary to do such tasks are outside the scope of
util-linux, but at least the ability to mount/umount a file system,
fdisk and partition management. Could it be ensured that one can 'mount'
disks under adverse conditions, at the very least, so that umount.static
would make sense? 



> The command rename(1) provides a new command line option --interactive to ask
> before overwriting.
>   
---
  How does rename compare with 'mmv'?  I note that in the manpage "SEE 
ALSO" section,  'mv' is listed, (not quite sure why?), but not a more 
related tool
like 'mmv'.
