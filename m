Return-Path: util-linux-owner@vger.kernel.org
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:60912 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932644AbcCQSXV (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Thu, 17 Mar 2016 14:23:21 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id AF77220DD9
	for <util-linux@vger.kernel.org>; Thu, 17 Mar 2016 14:23:20 -0400 (EDT)
Message-Id: <1458239000.908653.552257010.7074E741@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: cancelling the tests says that they all passed
Date: Thu, 17 Mar 2016 19:23:20 +0100
In-Reply-To: <201603171818.52599.sweet_f_a@gmx.de>
References: <1458207847.751745.551787010.6EE6554F@webmail.messagingengine.com>
 <201603171350.44094.sweet_f_a@gmx.de>
 <1458233386.879328.552147938.0BC34E2C@webmail.messagingengine.com>
 <201603171818.52599.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Thu, Mar 17, 2016, at 18:18, Ruediger Meier wrote:
> Could you show us
> $ cat /proc/sysvipc/shm

       key      shmid perms       size  cpid  lpid nattch   uid   gid  cuid  cgid      atime      dtime      ctime
         0     131072  1600     393216  1409   921      2  1000  1000  1000  1000 1458201259          0 1458201259
         0     163841  1600     393216  1413 19472      2  1000  1000  1000  1000 1458231784 1458231784 1458201259
         0     196610  1600     393216  1399   921      2  1000  1000  1000  1000 1458201260          0 1458201260
         0     229379  1600     393216  1399   921      2  1000  1000  1000  1000 1458201260          0 1458201260
         0     262148  1600     393216  1419  1474      2  1000  1000  1000  1000 1458201262 1458201262 1458201261
         0     294917  1600     393216  1419  1474      2  1000  1000  1000  1000 1458201262 1458201262 1458201261
         0     327686  1600     393216  1388   921      2  1000  1000  1000  1000 1458201262          0 1458201262
         0     360455  1600     393216  1416  2127      2  1000  1000  1000  1000 1458204570 1458204570 1458201265
         0     393224  1600     393216  1424   921      2  1000  1000  1000  1000 1458201265          0 1458201265
         0     425993  1600     393216  1490   921      2  1000  1000  1000  1000 1458201268          0 1458201268
         0     458762  1600     393216  1495   921      2  1000  1000  1000  1000 1458201268          0 1458201268
         0     491531  1600     393216  1508   921      2  1000  1000  1000  1000 1458201268          0 1458201268
         0     524300  1600     393216  1497   921      2  1000  1000  1000  1000 1458201268          0 1458201268
         0     557069  1600     393216  1405 18482      2  1000  1000  1000  1000 1458215908 1458215908 1458201269
         0     589838  1600     393216  1492   921      2  1000  1000  1000  1000 1458201270          0 1458201270
         0     622607  1600     393216  1493   921      2  1000  1000  1000  1000 1458201273          0 1458201273
         0     655376  1600     393216  1496   921      2  1000  1000  1000  1000 1458201274          0 1458201274
         0     688145  1600     393216  1417   921      2  1000  1000  1000  1000 1458201282          0 1458201282
         0     720914  1600     393216  1413 19472      2  1000  1000  1000  1000 1458231784 1458231784 1458201449
 -60920149    1081363   644         12 10036     0      0  1000  1000  1000  1000          0          0 1458215137
         0    1114132  1600     393216  1417   921      2  1000  1000  1000  1000 1458215476          0 1458215476

> Generally I think we should make a statement about "what is the minimum 
> kernel version" for util-linux.

A statement.  And let the tests check the version and print
a warning in case it's too old.

> Two years ago I decided for myself that 
> I should fix bugs for newer kernels first. On the other hand 2.6.32 
> would have been worth to support because it was officially maintained 
> from 2009 until last month!

I'm not expecting you to fix things.  It's just nice to put
things in a harsher environment and see how they hold up.  :)

> I guess the kernel syscall does not return error thus our fallocate 
> succeed but the file is empty. It's a kernel bug we can't fix. Or 
> should we add a stat() call to validate the syscall?

That sounds like a good idea: check, and double check.

Benno

-- 
http://www.fastmail.com - Accessible with your email software
                          or over the web

