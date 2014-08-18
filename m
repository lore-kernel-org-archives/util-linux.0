Return-Path: util-linux-owner@vger.kernel.org
Received: from message.mylangara.bc.ca ([142.35.159.25]:50350 "EHLO
	message.langara.bc.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbaHRA5b (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 17 Aug 2014 20:57:31 -0400
MIME-version: 1.0
Content-type: text/plain; charset=iso-2022-jp
Received: from langara.bc.ca ([127.0.0.1])
 by message.langara.bc.ca (Sun Java(tm) System Messaging Server 6.3-6.03 (built
 Mar 14 2008; 32bit)) with ESMTP id <0NAH0059N9BULO20@message.langara.bc.ca>
 for util-linux@vger.kernel.org; Sun, 17 Aug 2014 17:57:30 -0700 (PDT)
From: Steven Stewart-Gallus <sstewartgallus00@mylangara.bc.ca>
To: Linda Walsh <lkml@tlinx.org>
Cc: util-linux@vger.kernel.org
Message-id: <fb20984219ad.53f14f7a@langara.bc.ca>
Date: Mon, 18 Aug 2014 00:57:30 +0000 (GMT)
Subject: Re: Utilities don't take into account capabilities
In-reply-to: <53F11687.5060805@tlinx.org>
References: <fbcec6cf5352.53efd3e4@langara.bc.ca> <53F11687.5060805@tlinx.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> Seriously... What capabilities does mount need in order to function?

I can help out with this one.

> CAP_SYS_ADMIN
>        * Perform  a  range  of  system administration operations including:
quotactl(2),
>          mount(2), umount(2),  swapon(2),  swapoff(2),  sethostname(2),  and 
setdomain‐
>          name(2);
>        * perform  privileged syslog(2) operations (since Linux 2.6.37,
CAP_SYSLOG should
>          be used to permit such operations);
>        * perform IPC_SET and IPC_RMID operations on arbitrary System V IPC
objects;
>        * perform operations on trusted and security Extended Attributes (see
attr(5));
>        * use lookup_dcookie(2);
>        * use  ioprio_set(2)  to  assign  IOPRIO_CLASS_RT  and  (before   Linux
  2.6.25)
>          IOPRIO_CLASS_IDLE I/O scheduling classes;
>        * forge UID when passing socket credentials;
>        * exceed  /proc/sys/fs/file-max,  the  system-wide  limit  on  the
number of open
>          files, in system calls that open files (e.g.,  accept(2),  execve(2),
 open(2),
>          pipe(2));
>        * employ CLONE_NEWNS flag with clone(2) and unshare(2);
>        * call setns(2);
>        * perform KEYCTL_CHOWN and KEYCTL_SETPERM keyctl(2) operations;
>        * perform madvise(2) MADV_HWPOISON operation.

>From CAPABILITIES(7) in the Linux Programmer's Manual.
