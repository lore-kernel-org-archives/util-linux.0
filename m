Return-Path: util-linux-owner@vger.kernel.org
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:41074 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753749Ab3JXQ6O (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 24 Oct 2013 12:58:14 -0400
Received: from probook.site
	(dslb-084-057-067-069.pools.arcor-ip.net [84.57.67.69])
	by smtp.strato.de (RZmta 32.11 DYNA|AUTH)
	with (TLSv1.0:DHE-RSA-AES256-SHA encrypted) ESMTPSA id 0031fbp9OGoW8J
	for <util-linux@vger.kernel.org>;
	Thu, 24 Oct 2013 18:58:11 +0200 (CEST)
Date: Thu, 24 Oct 2013 18:58:10 +0200
From: Olaf Hering <olaf@aepfle.de>
To: util-linux@vger.kernel.org
Subject: fdisk lacks msdos partition support in gpt mode
Message-ID: <20131024165810.GA26722@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


The guys to decided to use gpt labels even on legacy systems. That
happens to work. But when it breaks its now difficult to see whats
actually on disk. Now that fdisk from util-linux 2.23.2 has gpt support
its unable to print the msdos partition table.

It would be nice if fdisk gets some do-it-anyway flag to ignore gpt for
a moment and at least dump such content.


Thanks.

Olaf
