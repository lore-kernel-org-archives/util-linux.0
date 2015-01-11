Return-Path: util-linux-owner@vger.kernel.org
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:54225 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750872AbbAKRPD (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 11 Jan 2015 12:15:03 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 241F420320
	for <util-linux@vger.kernel.org>; Sun, 11 Jan 2015 12:15:02 -0500 (EST)
Message-Id: <1420996501.3946435.212467333.26895F9A@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [RFC] should --version report the program's true name?
Date: Sun, 11 Jan 2015 18:15:01 +0100
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


$ ln -s setarch foo

$ ./foo --version
foo from util-linux 2.25.634-8501-dirty

But util-linux does not contain any program called "foo":

$ man foo
No manual entry for foo

Shouldn't --version report the name of the original program
instead of the name of the binary?  Just like the last line
of the --help output does:

$ ./foo --help | tail -1
For more details see setarch(8).

Benno

-- 
http://www.fastmail.com - A no graphics, no pop-ups email service

