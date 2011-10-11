Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:26255 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752266Ab1JKJbN (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 11 Oct 2011 05:31:13 -0400
Date: Tue, 11 Oct 2011 11:31:08 +0200
From: Karel Zak <kzak@redhat.com>
To: Dave Reisner <d@falconindy.com>
Cc: util-linux@vger.kernel.org, Dave Reisner <dreisner@archlinux.org>
Subject: Re: [PATCH 1/2] mountpoint: refactor exit path
Message-ID: <20111011093108.GC20392@nb.net.home>
References: <1318288456-22940-1-git-send-email-dreisner@archlinux.org> <20111011090603.GJ11730@nb.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111011090603.GJ11730@nb.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Oct 11, 2011 at 11:06:03AM +0200, Karel Zak wrote:
>  Applied, thanks.

 I completely forgot that we can use libmount for canonicalization. It
 means that the exit-path refactoring is unnecessary. Sorry. 

 The problem should be resolved in our git tree. Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
