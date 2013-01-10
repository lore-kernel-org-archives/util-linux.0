Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35145 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753400Ab3AJKzc (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 10 Jan 2013 05:55:32 -0500
Date: Thu, 10 Jan 2013 11:19:55 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/4] ipcmk: remove unnecessary create_key() function
Message-ID: <20130110101955.GA593@x2.net.home>
References: <1357760216-4068-1-git-send-email-kerolasa@iki.fi>
 <1357760216-4068-2-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1357760216-4068-2-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jan 09, 2013 at 07:36:54PM +0000, Sami Kerola wrote:
>  static int create_shm(size_t size, int permission)
>  {
> -	key_t key = create_key();
> +	key_t key = random();

 we already have random_get_bytes() in randutils.c, it seems better
 than introduce seed_random() and use random().

    random_get_bytes(&key, sizeof(key));


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
