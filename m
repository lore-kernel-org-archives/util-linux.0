Return-Path: util-linux-owner@vger.kernel.org
Received: from mail182.messagelabs.com ([85.158.139.83]:44588 "HELO
	mail182.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753633Ab1GRRMe convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 18 Jul 2011 13:12:34 -0400
From: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>
To: Marc-Antoine Perennou <Marc-Antoine@Perennou.com>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Date: Mon, 18 Jul 2011 19:12:30 +0200
Subject: RE: dmesg: fix segfqult
Message-ID: <7856072A9D04C24B82DFE2B1112FE38A08FE26D395@MCHP058A.global-ad.net>
References: <CACpTwpGZHf4dY72T6-nNLWCEU9CM2h58OQvCVgDZiKxsOorxVw@mail.gmail.com>
In-Reply-To: <CACpTwpGZHf4dY72T6-nNLWCEU9CM2h58OQvCVgDZiKxsOorxVw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Marc-Antoine Perennou wrote:

> An element declared as size_t cannot be detected as negative (len < 0
> is always false).
> This can lead to an infinite loop causing a segmentation fault.
> Use an int to solve this issue
> 
> Signed-off-by: Marc-Antoine Perennou <Marc-Antoine@Perennou.com>
> ---
>  sys-utils/dmesg.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
> index 867581d..91855a1 100644
> --- a/sys-utils/dmesg.c
> +++ b/sys-utils/dmesg.c
> @@ -362,7 +362,7 @@ static void safe_fwrite(const char *buf, size_t
> size, FILE *out)
> 
>  #ifdef HAVE_WIDECHAR
>  		wchar_t wc;
> -		size_t len = mbrtowc(&wc, p, size - i, &s);
> +		int len = mbrtowc(&wc, p, size - i, &s);
> 
>  		if (len == 0)				/* L'\0' */
>  			return;
> -- 
> 1.7.6.134.gcf13f6.dirty
> --

Interestingly, there are other projects which fell into the same trap:
* mc: https://bugzilla.redhat.com/show_bug.cgi?id=150569 

Have a nice day,
Berny
