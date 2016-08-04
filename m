Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:56892 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751541AbcHDKqL (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 4 Aug 2016 06:46:11 -0400
Date: Thu, 4 Aug 2016 12:45:19 +0200
From: Karel Zak <kzak@redhat.com>
To: Ales Novak <alnovak@suse.cz>
Cc: util-linux@vger.kernel.org, nfbrown@suse.com, jeffm@suse.com
Subject: Re: [PATCH] libmount: after colon, ignore double slashes in path
 start
Message-ID: <20160804104519.b4mlq2truvoacz4a@ws.net.home>
References: <1469018169-5650-1-git-send-email-alnovak@suse.cz>
 <1469018169-5650-2-git-send-email-alnovak@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1469018169-5650-2-git-send-email-alnovak@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jul 20, 2016 at 02:36:09PM +0200, Ales Novak wrote:
> +/*
> + * Compare two strings for equality, ignoring at most one trailing
> + * slash, and furthermore if there are double slashes right after
> + * the ':' in the string, it ignores them. That is, these strings
> + * are equal:
> + *   host:/path
> + *   host://path
> + *   host:/path/
> + *   host://path/
> + */
> +int streq_except_redundant_slashes(const char *s1, const char *s2)

Would be better to have a generic function streq_path() to compare
paths?

 foo///bar/aaa
 foo/bar/aaa
 foo/bar/aaa//

... all are the same.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
