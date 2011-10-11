Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60284 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752327Ab1JKJGJ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 11 Oct 2011 05:06:09 -0400
Date: Tue, 11 Oct 2011 11:06:03 +0200
From: Karel Zak <kzak@redhat.com>
To: Dave Reisner <d@falconindy.com>
Cc: util-linux@vger.kernel.org, Dave Reisner <dreisner@archlinux.org>
Subject: Re: [PATCH 1/2] mountpoint: refactor exit path
Message-ID: <20111011090603.GJ11730@nb.net.home>
References: <1318288456-22940-1-git-send-email-dreisner@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318288456-22940-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Oct 10, 2011 at 07:14:15PM -0400, Dave Reisner wrote:
>  	if (dev_devno)
>  		rc = print_devno(spec, &st);

 print_devno() returns -1 on error. Fixed.

> @@ -161,20 +161,23 @@ int main(int argc, char **argv)
>  
>  		if (!S_ISDIR(st.st_mode)) {
>  			if (!quiet)
> -				errx(EXIT_FAILURE, _("%s: not a directory"), spec);
> -			return EXIT_FAILURE;
> +				warnx(_("%s: not a directory"), spec);
> +			goto finish;
>  		}
>  		src = dir_to_device(spec);
>  		if (src == (dev_t)-1) {
>  			if (!quiet)
>  				printf(_("%s is not a mountpoint\n"), spec);
> -			return EXIT_FAILURE;
> +			goto finish;
>  		}
>  		if (fs_devno)
>  			printf("%u:%u\n", major(src), minor(src));
> -		else if (!quiet)
> +		else if (!quiet) {
>  			printf(_("%s is a mountpoint\n"), spec);
> +			rc = EXIT_SUCCESS;

 Fixed. (see Berny's email)

 Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
