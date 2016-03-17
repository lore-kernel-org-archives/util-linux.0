Return-Path: util-linux-owner@vger.kernel.org
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:38063 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935410AbcCQJoJ (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Thu, 17 Mar 2016 05:44:09 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 00BFE206A6
	for <util-linux@vger.kernel.org>; Thu, 17 Mar 2016 05:44:07 -0400 (EDT)
Message-Id: <1458207847.751745.551787010.6EE6554F@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: cancelling the tests says that they all passed
Date: Thu, 17 Mar 2016 10:44:07 +0100
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


When one hits ^C when the compilation phase of 'make check'
finishes and the first tests start executing, the script prints

  All 177 tests PASSED

before aborting.  That... doesn't seem quite right.


When I leave the tests to run to completion, it says:

  4 tests of 177 FAILED

The failed ones are these:

         ipcs: mk-rm-shm                                     ... FAILED (ipcs/mk-rm-shm)
         misc: fallocate                                     ... FAILED (misc/fallocate)
         misc: swaplabel                                     ... FAILED (misc/swaplabel)
         misc: ul                                            ... FAILED (misc/ul)

Benno

-- 
http://www.fastmail.com - The way an email service should be

