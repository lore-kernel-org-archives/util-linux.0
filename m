Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44442 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753698AbcJ0JOR (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 27 Oct 2016 05:14:17 -0400
Date: Thu, 27 Oct 2016 10:57:59 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v2] libfdisk: fix uninitialized fdisk_labelitem
Message-ID: <20161027085759.dwkg5karm6zeems3@ws.net.home>
References: <1477493259-14586-1-git-send-email-sweet_f_a@gmx.de>
 <1477494270-15856-1-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1477494270-15856-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Oct 26, 2016 at 05:04:30PM +0200, Ruediger Meier wrote:
>  libfdisk/src/label.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied.

> diff --git a/libfdisk/src/label.c b/libfdisk/src/label.c
> index 5cbbe42..0e83fdf 100644
> --- a/libfdisk/src/label.c
> +++ b/libfdisk/src/label.c
> @@ -416,7 +416,7 @@ int fdisk_locate_disklabel(struct fdisk_context *cxt, int n, const char **name,
>   */
>  int fdisk_get_disklabel_id(struct fdisk_context *cxt, char **id)
>  {
> -	struct fdisk_labelitem item;
> +	struct fdisk_labelitem item = {0};

I have added macro rather than {0}.

THANKS! :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
