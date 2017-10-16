Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57804 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751722AbdJPI6h (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 16 Oct 2017 04:58:37 -0400
Date: Mon, 16 Oct 2017 10:58:34 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] rfkill: expand all acronyms in type string descriptions
Message-ID: <20171016085834.u5ywmcgadkjtxbdu@ws.net.home>
References: <20171014213541.1666-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171014213541.1666-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Oct 14, 2017 at 10:35:41PM +0100, Sami Kerola wrote:
> Be as verbose as possible when user wants that.  This also fixes small typo
> from 7d2a9960ad that made gps to look like a GUID Partition Table.
> 
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  sys-utils/rfkill.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/sys-utils/rfkill.c b/sys-utils/rfkill.c
> index 195386c8f..2b667f7c7 100644
> --- a/sys-utils/rfkill.c
> +++ b/sys-utils/rfkill.c
> @@ -57,16 +57,16 @@ struct rfkill_type_str {
>  
>  static const struct rfkill_type_str rfkill_type_strings[] = {
>  	{ .type = RFKILL_TYPE_ALL,       .name = "all"           },
> -	{ .type = RFKILL_TYPE_WLAN,      .name = "wlan",         .desc = "Wireless LAN" },
> +	{ .type = RFKILL_TYPE_WLAN,      .name = "wlan",         .desc = "Wireless Local Area Network" },
>  	{ .type = RFKILL_TYPE_WLAN,      .name = "wifi"          },				/* alias */
>  	{ .type = RFKILL_TYPE_BLUETOOTH, .name = "bluetooth",    .desc = "Bluetooth" },
>  	{ .type = RFKILL_TYPE_UWB,       .name = "uwb",          .desc = "Ultra-Wideband" },
>  	{ .type = RFKILL_TYPE_UWB,       .name = "ultrawideband" }, /* alias */
> -	{ .type = RFKILL_TYPE_WIMAX,     .name = "wimax",        .desc = "WiMAX" },
> -	{ .type = RFKILL_TYPE_WWAN,      .name = "wwan",         .desc = "Wireless WAN" },
> -	{ .type = RFKILL_TYPE_GPS,       .name = "gps",          .desc = "GPT" },
> -	{ .type = RFKILL_TYPE_FM,        .name = "fm",           .desc = "FM" },
> -	{ .type = RFKILL_TYPE_NFC,       .name = "nfc",          .desc = "NFC" },
> +	{ .type = RFKILL_TYPE_WIMAX,     .name = "wimax",        .desc = "Worldwide Interoperability for Microwave Access" },
> +	{ .type = RFKILL_TYPE_WWAN,      .name = "wwan",         .desc = "Wireless Wide Area Network" },
> +	{ .type = RFKILL_TYPE_GPS,       .name = "gps",          .desc = "Global Positioning System" },
> +	{ .type = RFKILL_TYPE_FM,        .name = "fm",           .desc = "Frequency Modulation radio" },
> +	{ .type = RFKILL_TYPE_NFC,       .name = "nfc",          .desc = "Near-Field Communication" },
>  	{ .type = NUM_RFKILL_TYPES,      .name = NULL            }
>  };

So, the default "list" output will be *again* backwardly incompatible :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
