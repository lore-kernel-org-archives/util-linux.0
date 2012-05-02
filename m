Return-Path: util-linux-owner@vger.kernel.org
Received: from mailbigip.dreamhost.com ([208.97.132.5]:54870 "EHLO
	homiemail-a37.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753090Ab2EBOwz convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 2 May 2012 10:52:55 -0400
Subject: Re: mkfs.minix -3 creates incorrect and limited filesystem
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Vladimir =?UTF-8?Q?=27=CF=86-coder/phcoder=27?= Serbinenko
	<phcoder@gmail.com>
Cc: util-linux@vger.kernel.org
In-Reply-To: <4FA1417D.8010704@gmail.com>
References: <4FA1417D.8010704@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 02 May 2012 16:52:49 +0200
Message-ID: <1335970369.2734.17.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, 2012-05-02 at 16:15 +0200, Vladimir 'φ-coder/phcoder' Serbinenko
wrote:
> --- util-linux-2.20.1/disk-utils/mkfs.minix.c	2011-10-11 15:23:46.000000000 +0200
> +++ util-linux-2.20.1-mod/disk-utils/mkfs.minix.c	2012-05-02 13:56:09.993347189 +0200
> @@ -487,7 +487,7 @@ static void setup_tables(void) {
>  
>  	if (fs_version == 3) {
>  		Super3.s_log_zone_size = 0;
> -		Super3.s_blocksize = BLOCKS;
> +		Super3.s_blocksize = MINIX_BLOCK_SIZE;
>  	}
>  	else {
>  		Super.s_log_zone_size = 0;
> @@ -773,7 +773,7 @@ int main(int argc, char ** argv) {
>  	if (fs_version == 3)
>  		magic = MINIX3_SUPER_MAGIC;
>  
> -	if (fs_version == 2) {
> +	else if (fs_version == 2) {
>  		if (namelen == 14)
>  			magic = MINIX2_SUPER_MAGIC;
>  		else
> 

Correct, however this is already fixed in new versions.

Thanks,
Davidlohr


