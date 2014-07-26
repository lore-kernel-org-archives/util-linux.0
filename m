Return-Path: util-linux-owner@vger.kernel.org
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36522 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750855AbaGZMkW (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sat, 26 Jul 2014 08:40:22 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by gateway1.nyi.internal (Postfix) with ESMTP id 7F375223EA
	for <util-linux@vger.kernel.org>; Sat, 26 Jul 2014 08:40:20 -0400 (EDT)
Message-Id: <1406378420.29449.145898149.3B1EDA38@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: "Util-Linux" <util-linux@vger.kernel.org>
Cc: Ondrej Oprala <ooprala@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: hwclock --compare segfaults when run as normal user
Date: Sat, 26 Jul 2014 14:40:20 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Hi,

On my system there is no /etc/adjtime file, and then:

$ ./hwclock --compare
Segmentation fault

When run as root, it runs fine.


$ ./hwclock --version
hwclock from util-linux 2.25

Benno

-- 
http://www.fastmail.fm - mmm... Fastmail...

