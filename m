Return-Path: util-linux-owner@vger.kernel.org
Received: from bombadil.infradead.org ([198.137.202.9]:48026 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754609AbbKQVEo (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 17 Nov 2015 16:04:44 -0500
Date: Tue, 17 Nov 2015 13:04:43 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Casper Ti. Vector" <caspervector@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] linux_reboot.h: support 1-argument reboot() from
 alternative libc.
Message-ID: <20151117210443.GA31873@infradead.org>
References: <3122dea1b0bbfab174b9e1cc70aec72676568f52.1447762216.git.CasperVector@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3122dea1b0bbfab174b9e1cc70aec72676568f52.1447762216.git.CasperVector@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Nov 17, 2015 at 04:54:15PM +0800, Casper Ti. Vector wrote:
> Original code assumes 1-argument reboot() is only provided by glibc 2.x
> and later; but as far as the patch author knows, at least the following
> alternative C libraries for linux also provide the 1-argument variant:
> 
> * uclibc: all public releases.
> * dietlibc: 0.7.2 and all later releases; reboot() was not provided in
>             0.7.1 and earlier versions.
> * musl: all public releases.
> * klibc: all public releases.
> * bionic: all public releases.
> 
> ... which should already cover most use cases.

Or rather all useful cases.  I'd say remove the old version
entirely and the wrappers entirely.
