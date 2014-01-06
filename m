Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:2354 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752997AbaAFIJ6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 6 Jan 2014 03:09:58 -0500
Date: Mon, 6 Jan 2014 09:09:53 +0100
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: "Dale R. Worley" <worley@alum.mit.edu>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: losetup "-p" option is not documented
Message-ID: <20140106080953.GE4435@x2.net.home>
References: <201312182232.rBIMWPWN020104@hobgoblin.ariadne.com>
 <CAG27Bk0jsee=nEOUz-m-RRF0cO=u36mqduhd-w1226=S+Yw_SQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk0jsee=nEOUz-m-RRF0cO=u36mqduhd-w1226=S+Yw_SQ@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Dec 19, 2013 at 09:46:27AM +0000, Sami Kerola wrote:
> +.IP "\fB\-p, \-\-pass-fd\fP \fIfile descriptior\fP"
> +This option is no longer supported.
>  
>  .SH ENCRYPTION
>  .B Cryptoloop is no longer supported in favor of dm-crypt. For more details see
> diff --git a/sys-utils/losetup.c b/sys-utils/losetup.c
> index 70d9155..7708fd9 100644
> --- a/sys-utils/losetup.c
> +++ b/sys-utils/losetup.c
> @@ -538,7 +538,7 @@ int main(int argc, char **argv)
>  			list = 1;
>  			break;
>  		case 'p':
> -                        warn(_("--pass-fd is no longer supported"));
> +			warnx(_("--pass-fd is no longer supported"));
>  			break;

 I have removed the option (and also -e and -E) from code and man page
 at all, I don't think we have to maintain the warnings for ever.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
