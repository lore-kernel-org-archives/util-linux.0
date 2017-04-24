Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59986 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933802AbdDXKcQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 24 Apr 2017 06:32:16 -0400
Date: Mon, 24 Apr 2017 12:32:12 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 06/10] misc: clarify ternary operators with parentheses
Message-ID: <20170424103212.sqgix5wsechxlnxd@ws.net.home>
References: <20170423205821.7444-1-kerolasa@iki.fi>
 <20170423205821.7444-7-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170423205821.7444-7-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Apr 23, 2017 at 09:58:17PM +0100, Sami Kerola wrote:
> Compilers probably got these evaluations right, but it is best not to leave
> any room of interpretation what is the human intention.

 Not sure if I like the patch.... the operators precedence is
 important to understand C code, not sure if we want to use '(' ')'
 everywhere to keep readers uneducated. 
 
 Yes, in some complex conditions it makes sense (multi-line if()), but
 this is not the case.

> -	return lb->flags & FDISK_LABEL_FL_REQUIRE_GEOMETRY ? 1 : 0;
> +	return (lb->flags & FDISK_LABEL_FL_REQUIRE_GEOMETRY) ? 1 : 0;

 All the "<someting> ? 1 : 0" is non-elegant, what about:

     return !!(lb->flags & FDISK_LABEL_FL_REQUIRE_GEOMETRY);

 to keep code simple, fast and humans happy :)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
