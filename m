Return-Path: util-linux-owner@vger.kernel.org
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:58596 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753129AbaJTTwT (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 20 Oct 2014 15:52:19 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by gateway2.nyi.internal (Postfix) with ESMTP id 181CF20966
	for <util-linux@vger.kernel.org>; Mon, 20 Oct 2014 15:52:19 -0400 (EDT)
Message-Id: <1413834738.3279286.181227401.682D2FFB@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: the option --label-nested of sfdisk
Date: Mon, 20 Oct 2014 21:52:18 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Hi,

Recently the option --label-nested (to specify the type of a nested label
in a GPT) has been added to sfdisk.  But this name, --label-nested, it...
doesn't sound very English, it is not how one would say this in English.

Upcoming patch changes it to --nested-label, also because when using
long options it is enough to use the first few letters of an option to
choose one unequivocally, but when having both --label and --label-nested
one can no longer do something like "--lab bsd".  After the patch one can
do that again, /and/ use "--nest bsd" too, which is short and very clear.

Benno

-- 
http://www.fastmail.fm - IMAP accessible web-mail

