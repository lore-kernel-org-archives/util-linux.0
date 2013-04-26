Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44773 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753122Ab3DZLaj (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 26 Apr 2013 07:30:39 -0400
Date: Fri, 26 Apr 2013 13:30:26 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 04/33] cfdisk: add long options to the command
Message-ID: <20130426113026.GD4839@x2.net.home>
References: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
 <1365882901-11429-5-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1365882901-11429-5-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Apr 13, 2013 at 08:54:32PM +0100, Sami Kerola wrote:
> -	done < <(lsblk -pnro name,type)
> +	done <<<"$(lsblk -pnro "name,type")"

 Not applied.

 Please, don't mix different issues in the same patch. 

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
