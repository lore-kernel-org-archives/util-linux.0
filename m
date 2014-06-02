Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:48447 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752383AbaFBJms (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 2 Jun 2014 05:42:48 -0400
Date: Mon, 2 Jun 2014 11:42:43 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: build-sys: minor issues
Message-ID: <20140602094243.GM9000@x2.net.home>
References: <201406020056.17074.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201406020056.17074.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jun 02, 2014 at 12:56:16AM +0200, Ruediger Meier wrote:
> 1. ./configure --enable-all-programs
> also triggers --enable-deprecated-last. Would be nice to exclude this 
> deprecated stuff somehow.

 fixed, thanks for your report.

> 2. make dist
> changes files in source dir, which makes the git clone dirty. Would be 
> nice if we could avoid this somehow.

 What files? I see po/ stuff modification and it's more political
 issue than technical. The reason is that I update po/ only once
 before release (to avoid many many huge commits with irrelevant
 changes).

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
