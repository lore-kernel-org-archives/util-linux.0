Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:60784 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752408AbcGSJtl (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 19 Jul 2016 05:49:41 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Tobias Stoeckmann <tobias@stoeckmann.org>
Subject: Re: [PATCH] Fix segmentation fault in tailf on 32 bit
Date: Tue, 19 Jul 2016 11:49:37 +0200
Cc: util-linux@vger.kernel.org
References: <20160710141407.GA26802@localhost>
In-Reply-To: <20160710141407.GA26802@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201607191149.37180.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sunday 10 July 2016, Tobias Stoeckmann wrote:
> tailf crashes with a segmentation fault when used with a file that is
> exactly 4GB in size due to an integer overflow between off_t and
> size_t:

Note that tailf is deprecated and will be removed in a few months. It's 
better to use tail -f (from coreutils),

cu,
Rudi
