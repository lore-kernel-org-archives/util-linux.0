Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52523 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750811Ab3IZHxK (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 26 Sep 2013 03:53:10 -0400
Date: Thu, 26 Sep 2013 09:53:07 +0200
From: Karel Zak <kzak@redhat.com>
To: Namhyung Kim <namhyung@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 3/4] libmount: Set each optstr's to NULL if failed
Message-ID: <20130926075307.GD5101@x2.net.home>
References: <1380123126-3030-1-git-send-email-namhyung@gmail.com>
 <1380123126-3030-3-git-send-email-namhyung@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380123126-3030-3-git-send-email-namhyung@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Sep 26, 2013 at 12:32:05AM +0900, Namhyung Kim wrote:
> When mnt_split_optstr() failed in the middle, vfs, fs, user optstr's
> are freed but not reset.  It can lead to double frees at the end of
> mnt_fs_{ap,pre}pend_options().

 It's bug that mnt_fs_{ap,pre}pend_options() functions use the
 pointers after failed  mnt_split_optstr().

 Anyway, it's probably better to be robust here so applied and also
 fixed mnt_fs_{ap,pre}pend_options().

 Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
