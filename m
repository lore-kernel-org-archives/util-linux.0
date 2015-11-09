Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:50183 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752199AbbKIIvh (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 9 Nov 2015 03:51:37 -0500
Date: Mon, 9 Nov 2015 09:51:35 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 07/12] include/blkdev: add open_blkdev_or_file() function
Message-ID: <20151109085135.GP19508@ws.net.home>
References: <1446319284-24778-1-git-send-email-kerolasa@iki.fi>
 <1446319284-24778-8-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1446319284-24778-8-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Oct 31, 2015 at 07:21:19PM +0000, Sami Kerola wrote:
> +int open_blkdev_or_file(const char *name, const int oflag)
> +{
> +	int fd;
> +	struct stat ftype;
> +
> +	if (stat(name, &ftype) < 0)
> +		return -1;
> +	if (S_ISBLK(ftype.st_mode)) {
> +		fd = open(name, oflag | O_EXCL);
> +	} else
> +		fd = open(name, oflag);
> +	if (-1 < fd && !is_same_inode(fd, name)) {
> +		close(fd);
> +		errno = EBADFD;
> +		return -1;
> +	}
> +	if (-1 < fd && S_ISBLK(ftype.st_mode) && blkdev_is_misaligned(fd))
> +		warnx(_("warning: %s is misaligned"), name);
> +	return fd;
> +}

 Hmmm... this abstraction introduces extra stat() calls. Would be
 enough to use is_same_inode() directly in the code to reuse struct
 stat?
    
    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
