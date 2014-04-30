Return-Path: util-linux-owner@vger.kernel.org
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:47092 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758192AbaD3IwW (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 30 Apr 2014 04:52:22 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 4723320DCF
	for <util-linux@vger.kernel.org>; Wed, 30 Apr 2014 04:52:21 -0400 (EDT)
Message-Id: <1398847941.19293.112034049.7CA00422@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: cytune: misnamed long options
Date: Wed, 30 Apr 2014 10:52:21 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Hi,

According to the code and the man page of cytune, the option -g
shows the current values of the threshold and the flush timeout,
and option -G shows the default values.  But the corresponding
long options of those two are: --get-threshold and --get-flush.
Confusing.  Shouldn't those be changed to --get-current and
--get-defaults?  (Or the first one maybe just --get?)  However,
the docs say not to change any options.  What to do?  Sami?

Regards,

Benno

-- 
http://www.fastmail.fm - The professional email service

