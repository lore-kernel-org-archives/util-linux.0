Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39079 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753668AbaILJ0Q (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 12 Sep 2014 05:26:16 -0400
Date: Fri, 12 Sep 2014 11:26:04 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 12/17] eject: add struct eject_control to remove global
 variables
Message-ID: <20140912092604.GV21325@x2.net.home>
References: <1410093785-17537-1-git-send-email-kerolasa@iki.fi>
 <1410093785-17537-13-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1410093785-17537-13-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Sep 07, 2014 at 01:43:00PM +0100, Sami Kerola wrote:
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  sys-utils/eject.c | 394 +++++++++++++++++++++++++++---------------------------
>  1 file changed, 198 insertions(+), 196 deletions(-)
> 
> diff --git a/sys-utils/eject.c b/sys-utils/eject.c
> index 03744c7..767ede7 100644
> --- a/sys-utils/eject.c
> +++ b/sys-utils/eject.c
> @@ -81,31 +81,34 @@ static const char * const hotplug_subsystems[] = {
>  	"ccw"
>  };
>  
> -/* Global Variables */
> -static int a_option; /* command flags and arguments */
> -static int c_option;
> -static int d_option;
> -static int f_option;
> -static int F_option;
> -static int n_option;
> -static int q_option;
> -static int r_option;
> -static int s_option;
> -static int t_option;
> -static int T_option;
> -static int X_option;
> -static int v_option;
> -static int x_option;
> -static int p_option;
> -static int m_option;
> -static int M_option;
> -static int i_option;
> -static int a_arg;
> -static int i_arg;
> -static long int c_arg;
> -static long int x_arg;
> -
> -struct libmnt_table *mtab;
> +struct eject_control {
> +	struct libmnt_table *mtab;
> +	char *device;			/* device or mount point to be ejected */
> +	int fd;				/* file descriptor for device */
> +	uint32_t 			/* command flags and arguments */

 Again, don't be creative, use "unsigned int". The reality is that
 you have zero control on the way how compiler pack the bits.

C99:

An implementation may allocate any addressable storage unit large
enough to hold a bit- field. If enough space remains, a bit-field that
immediately follows another bit-field in a structure shall be packed
into adjacent bits of the same unit. If insufficient space remains,
whether a bit-field that does not fit is put into the next unit or
overlaps adjacent units is implementation-defined. The order of
allocation of bit-fields within a unit (high-order to low-order or
low-order to high-order) is implementation-defined. The alignment of
the addressable storage unit is unspecified.


 We usually use uintXX_t for on-disk data, to be sure with
 large numbers (uintmax_t) or for things that have any dependence on
 system. It's really unnecessary for any random control struct.

        Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
