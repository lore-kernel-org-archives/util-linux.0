Return-Path: util-linux-owner@vger.kernel.org
Received: from stoneboat.aleph1.co.uk ([80.68.88.63]:40793 "EHLO
	stoneboat.aleph1.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754529Ab2JCKis (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 3 Oct 2012 06:38:48 -0400
Date: Wed, 3 Oct 2012 11:21:47 +0100
From: Wookey <wookey@wookware.org>
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: util-linux@vger.kernel.org, linaro-dev@lists.linaro.org
Subject: Re: Add AArch64 support into util-linux
Message-ID: <20121003102147.GH24695@stoneboat.aleph1.co.uk>
References: <506C05E7.50400@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <506C05E7.50400@linaro.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

+++ Marcin Juszkiewicz [2012-10-03 10:31 +0100]:
> Attached patch fixed build problem when util-linux is built for AArch64
> architecture.

Upstream also needs updated config.{sub,guess} from autotools-dev
20120210.1 or later, to make it aware of new arches, including aarch64.
Preferably an autoreconf.


Wookey
-- 
Principal hats:  Linaro, Emdebian, Wookware, Balloonboard, ARM
http://wookware.org/
