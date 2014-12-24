Return-Path: util-linux-owner@vger.kernel.org
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54632 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751721AbaLXQfw (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 24 Dec 2014 11:35:52 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 5B92220BF2
	for <util-linux@vger.kernel.org>; Wed, 24 Dec 2014 11:35:49 -0500 (EST)
Message-Id: <1419438949.242820.206484249.1D540D03@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: setarch cannot set all listed architectures
Date: Wed, 24 Dec 2014 17:35:49 +0100
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Hi,

The man page of setarch says for the option --list: "List the architectures
that can be set."  However...

$ ./setarch --list   
uname26
linux32
linux64
i386
i486
i586
i686
athlon
x86_64
ia64

$ ./setarch x86_64 uname -m
setarch: x86_64: Unrecognized architecture

Huh?

$ ./setarch ia64 uname -m
setarch: ia64: Unrecognized architecture

$ ./setarch linux64 uname -m
i686

$ ./setarch --version
setarch from util-linux 2.25.548-fe2c9

Maybe --list should not be listing x86_64 and ia64 on this machine?
Or maybe the error message in these cases should say "Cannot set
the requested architecture" instead?

Benno

-- 
http://www.fastmail.com - Access your email from home and the web

