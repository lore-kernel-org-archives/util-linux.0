Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60040 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754194AbcHCJhN (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 3 Aug 2016 05:37:13 -0400
Date: Wed, 3 Aug 2016 11:28:58 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 5/8] Prevent AUTOCLEAR detach race
Message-ID: <20160803092858.ed7zill5wfni6mfq@ws.net.home>
References: <c83ba048-2d5e-da62-4a99-2d05f75add4a@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c83ba048-2d5e-da62-4a99-2d05f75add4a@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Aug 02, 2016 at 07:58:29PM +0200, Stanislav Brabec wrote:
> Kernel needs some time to delete a device after losetup --detach. If the losetup
> --find is called just after losetup --delete, it can sometimes attempt to
> recycle the device that is just being released. To prevent this race,
> clear the AUTOCLEAR flag of the device.
> 
> Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
> ---
>  sys-utils/losetup.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/sys-utils/losetup.c b/sys-utils/losetup.c
> index 28cde2b..ba096fe 100644
> --- a/sys-utils/losetup.c
> +++ b/sys-utils/losetup.c
> @@ -720,6 +720,12 @@ int main(int argc, char **argv)
>  				/* We found a device to recycle. Do not check
>  				 * for conflict. If it is conflicting, then
>  				 * user was already warned in past. */
> +				lc.info.lo_flags &= !LO_FLAGS_AUTOCLEAR;
> +				if (loopcxt_set_status(&lc)) {
> +					loopcxt_deinit(&lc);
> +					errx(EXIT_FAILURE, _("%s: failed to re-use loop device"),
> +					      loopcxt_get_device(&lc));
> +				}

This is strange, what if the device we want to reuse has been created
by mount(8) and AUTOCLEAR flag is wanted.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
