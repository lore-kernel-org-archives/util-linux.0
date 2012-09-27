Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:46438 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753702Ab2I0Oe7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 27 Sep 2012 10:34:59 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id B0D74A2111
	for <util-linux@vger.kernel.org>; Thu, 27 Sep 2012 16:34:58 +0200 (CEST)
Date: Thu, 27 Sep 2012 16:34:58 +0200
From: Philipp Thomas <pth@suse.de>
To: util-linux@vger.kernel.org
Cc: Werner Fink <werner@suse.de>
Subject: Merge of sulogin in 2.22
Message-ID: <20120927143458.GB31742@paradies.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The version of sulogin in util-linux lacks the upstream patch that adds
support for multiple consoles, which is a vital feature for us.  Would you
accept a patch that adds this feature to util-linux's version of sulogin? 
In that case we could drop sulogin from our sysvinit package.

Philipp
