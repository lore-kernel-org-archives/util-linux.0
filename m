Return-Path: util-linux-owner@vger.kernel.org
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:53389 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759780AbbA0VKB (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 27 Jan 2015 16:10:01 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id D06D720EF5
	for <util-linux@vger.kernel.org>; Tue, 27 Jan 2015 16:09:57 -0500 (EST)
Message-Id: <1422392997.3305312.219689461.6A470ED7@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: ./setarch --list complains
Date: Tue, 27 Jan 2015 22:09:57 +0100
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


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
setarch: no architecture argument specified

$ ./setarch --version
setarch from util-linux 2.26.rc1-35-aaa0b

Benno

-- 
http://www.fastmail.com - Or how I learned to stop worrying and
                          love email again

