Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38682 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751281AbbBXLxd (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Feb 2015 06:53:33 -0500
Date: Tue, 24 Feb 2015 12:53:22 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 11/16] tailf: check printing criteria more carefully
Message-ID: <20150224115322.GM19430@ws.net.home>
References: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
 <1424616106-580-12-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1424616106-580-12-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Feb 22, 2015 at 02:41:41PM +0000, Sami Kerola wrote:
> -	if (lseek(fd, *size, SEEK_SET) != (off_t)-1) {
> +	if (st.st_ino != old->st_ino || st.st_dev != old->st_dev
> +	    || (old->st_mtime < st.st_mtime && st.st_size <= old->st_size))
> +		old->st_size = 0;

 So.. if I remove (truncate) last line from 1GiB file then tailf will 
 print all the file *again*? Would be better to reset to st.st_size if the
 size is smaller than old->st_size?

 Or maybe if you want to support "echo 1 >| file" use case than add a
 new option (--rewind) or so.

> +	if (lseek(fd, old->st_size, SEEK_SET) != (off_t)-1) {
>  		ssize_t rc, wc;
>  
>  		while ((rc = read(fd, buf, sizeof(buf))) > 0) {
> @@ -123,16 +128,16 @@ roll_file(const char *filename, off_t *size)
>  	 * avoids data duplication. If we read nothing or hit an error, reset
>  	 * to the reported size, this handles truncated files.
>  	 */
> -	*size = (pos != -1 && pos != *size) ? pos : st.st_size;
> +	old->st_size = (pos != -1 && pos != old->st_size) ? pos : 0;

 This way how to reset seems better.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
