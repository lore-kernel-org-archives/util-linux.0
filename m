Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40426 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751439AbdFZUkL (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 26 Jun 2017 16:40:11 -0400
Date: Mon, 26 Jun 2017 22:40:06 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] uuidparse: fix getopt crash
Message-ID: <20170626204006.2s4v3equcf5cg5ct@ws.net.home>
References: <20170626162006.25240-1-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170626162006.25240-1-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jun 26, 2017 at 06:20:06PM +0200, Ruediger Meier wrote:
> From: Ruediger Meier <ruediger.meier@ga-group.nl>
> 
> $ ./uuidparse --unknownopt
> Segmentation fault (core dumped)
> 
> Hehe, this is the first real bug found by 'make checkusage'.

Nice ;-) Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
