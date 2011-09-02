Return-Path: util-linux-owner@vger.kernel.org
Received: from odpn1.odpn.net ([212.40.96.53]:55253 "EHLO odpn1.odpn.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751418Ab1IBG5X (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 2 Sep 2011 02:57:23 -0400
Received: from odpn1.odpn.net [212.40.96.53]
	by odpn1.odpn.net for util-linux@vger.kernel.org
	id 1QzNgo-0006Ko-AV; Fri, 02 Sep 2011 08:57:22 +0200
From: "Gabor Z. Papp" <gzp@papp.hu>
To: util-linux@vger.kernel.org
Subject: agetty 2.20 --noclear
Date: Fri, 02 Sep 2011 08:57:22 +0200
Message-ID: <x662lbqvn1@gzp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

lo lo,

util-linux's agetty never cleared the terminal before 2.20.

I don't think its good idea to set clear screen to default, since
after upgrading from <2.20 versions, everywhere have to modify the
inittab with the --no-clear option.

Also this Num/Caps/Scroll Lock on/off printf hint in the code looks
quite funny... Can't be set this optional and not printed by default?

Earlier versions weren't so noisy.
