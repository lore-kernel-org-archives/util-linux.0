Return-Path: util-linux-owner@vger.kernel.org
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43917 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757599Ab3E3Vzf (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Thu, 30 May 2013 17:55:35 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 7EDC620A4A
	for <util-linux@vger.kernel.org>; Thu, 30 May 2013 17:55:34 -0400 (EDT)
Message-Id: <1369950934.2640.140661237825437.1D1D200C@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: column: does '--fillrows' fill columns first?
Date: Thu, 30 May 2013 23:55:34 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Hello,

The man page of 'column' says that it fills rows before columns, and
for the option '--fillrows' it says that it then fills columns first.
(Seems like a very poor naming choice to me, but... okay.)  But then,
the help text says that '--fillrows' fills rows first.  The latter
seems to be correct, because '-x' never seems to have any effect.

So, how does one fill columns first?  Also: what is '-c' supposed to
do?  It doesn't seem to have any effect ever either.

Regards,

Benno

-- 
http://www.fastmail.fm - Choose from over 50 domains or use your own

