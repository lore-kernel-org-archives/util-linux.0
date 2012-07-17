Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcagg.dreamhost.com ([208.97.132.66]:51151 "EHLO
	homiemail-a60.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751366Ab2GQKDk (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 17 Jul 2012 06:03:40 -0400
Subject: Re: [pull] static analysis, and help to translator
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
In-Reply-To: <CAG27Bk0nrNH8gWAa75mqZ1sLimGgq9c1AsA4JED3z5hrUjERzw@mail.gmail.com>
References: <CAG27Bk0qDyt0q7vVtCeOgdWDN_r7mW+gUVnyMLUjY1CnbT+LZw@mail.gmail.com>
	 <1342460649.2643.3.camel@offbook>
	 <CAG27Bk0nrNH8gWAa75mqZ1sLimGgq9c1AsA4JED3z5hrUjERzw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 17 Jul 2012 12:03:36 +0200
Message-ID: <1342519416.3068.1.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, 2012-07-17 at 08:06 +0200, Sami Kerola wrote:
> On Mon, Jul 16, 2012 at 7:44 PM, Davidlohr Bueso <dave@gnu.org> wrote:
> >>   translation: unify file open error messages (2012-07-15 10:39:57 +0200)
> >
> > Sami, this breaks regression test scripts; please be sure to always run
> > them when making general changes across all utils.
> 
> Hi Dave et.al.
> 
> Good point. I had a look of tests and found couple other things being
> broken as well, which are fixed in pull below. Could you Dave have
> look of fdisk test fix? I think I got assumption right, but I really
> would like to add reviewed-by line.
> 
> https://github.com/kerolasa/lelux-utiliteetit/commit/f6d755739df0c48e17e0eb85a485ad1aa4d59bc7
> 
> 
> The following changes since commit cc924cc086cf0363f49edd6ce14947acae2dad77:
> 
>   mkfs.cramfs: fix compiler warning [-Wmissing-prototypes] (2012-07-16
> 18:57:30 +0200)
> 
> are available in the git repository at:
> 
>   git://github.com/kerolasa/lelux-utiliteetit.git test-fixes
> 
> for you to fetch changes up to f6d755739df0c48e17e0eb85a485ad1aa4d59bc7:
> 
>   fdisk: change expected test output (2012-07-17 07:45:36 +0200)
> 
> ----------------------------------------------------------------
> Sami Kerola (3):
>       tests: partx changed default output format
>       tests: look: add words file
>       fdisk: change expected test output
> 
>  fdisks/fdisk.c                     |  7 +++++--
>  tests/expected/fdisk/oddinput      |  4 ++--
>  tests/expected/partx/partx-bsd     |  5 +++--
>  tests/expected/partx/partx-dos+bsd |  9 +++++----
>  tests/expected/partx/partx-gpt     | 11 ++++++-----
>  tests/expected/partx/partx-sgi     |  5 +++--
>  tests/expected/partx/partx-sun     |  5 +++--
>  tests/ts/look/separator            |  4 +---
>  tests/ts/look/words                |  3 +++
>  9 files changed, 31 insertions(+), 22 deletions(-)
>  create mode 100644 tests/ts/look/words
> 
> diff --git a/fdisks/fdisk.c b/fdisks/fdisk.c
> index 32b6de9..55fd751 100644
> --- a/fdisks/fdisk.c
> +++ b/fdisks/fdisk.c
> @@ -1761,8 +1761,11 @@ static void
> print_partition_table_from_option(char *device, unsigned long sector
>  	int gb;
> 
>  	struct fdisk_context *cxt = fdisk_new_context_from_filename(device,
> 1);	/* read-only */
> -	if (!cxt)
> -		err(EXIT_FAILURE, _("cannot open %s"), device);
> +	if (!cxt) {
> +		if (errno)
> +			err(EXIT_FAILURE, _("cannot open %s"), device);
> +		errx(EXIT_FAILURE, _("cannot open %s: too small device"), device);

I'm currently working on fine grain error handling, so for now, I'd be
happy just leaving the cannot open device message, and not worrying
about device too small - this isn't very meaningful to the user either,
IMHO.

Thanks,
Davidlohr

> +	}
>  	if (sector_size)  /* passed -b option, override autodiscovery */
>  		cxt->phy_sector_size = cxt->sector_size = sector_size;
>  	/* passed CHS option(s), override autodiscovery */
> diff --git a/tests/expected/fdisk/oddinput b/tests/expected/fdisk/oddinput
> index d90866b..bd70066 100644
> --- a/tests/expected/fdisk/oddinput
> +++ b/tests/expected/fdisk/oddinput
> @@ -9,6 +9,6 @@ Sector size (logical/physical): 512 bytes / 512 bytes
>  I/O size (minimum/optimal): 512 bytes / 512 bytes
> 
>  Nonexistant file
> -lt-fdisk: unable to open _a_file_that_does_not_exist_: No such file
> or directory
> +lt-fdisk: cannot open _a_file_that_does_not_exist_: No such file or directory
>  Too small file
> -lt-fdisk: unable to open oddinput.toosmall: Success
> +lt-fdisk: cannot open oddinput.toosmall: too small device
> diff --git a/tests/expected/partx/partx-bsd b/tests/expected/partx/partx-bsd
> index d4be5c5..15568c4 100644
> --- a/tests/expected/partx/partx-bsd
> +++ b/tests/expected/partx/partx-bsd
> @@ -1,2 +1,3 @@
> -# 1:      7936-    12799 (     4864 sectors,      2 MB)
> -# 2:     12544-    16127 (     3584 sectors,      1 MB)
> +NR START   END SECTORS SIZE NAME UUID
> + 1  7936 12799    4864 2.4M
> + 2 12544 16127    3584 1.8M
> diff --git a/tests/expected/partx/partx-dos+bsd
> b/tests/expected/partx/partx-dos+bsd
> index 3242a6c..75cdfe8 100644
> --- a/tests/expected/partx/partx-dos+bsd
> +++ b/tests/expected/partx/partx-dos+bsd
> @@ -1,4 +1,5 @@
> -# 1:        32-     7679 (     7648 sectors,      3 MB)
> -# 2:      7680-    16383 (     8704 sectors,      4 MB)
> -# 5:      7936-    12799 (     4864 sectors,      2 MB)
> -# 6:     12544-    16127 (     3584 sectors,      1 MB)
> +NR START   END SECTORS SIZE NAME UUID
> + 1    32  7679    7648 3.8M
> + 2  7680 16383    8704 4.3M
> + 5  7936 12799    4864 2.4M
> + 6 12544 16127    3584 1.8M
> diff --git a/tests/expected/partx/partx-gpt b/tests/expected/partx/partx-gpt
> index 0a1d491..c941f36 100644
> --- a/tests/expected/partx/partx-gpt
> +++ b/tests/expected/partx/partx-gpt
> @@ -1,5 +1,6 @@
> -# 1:        34-     2047 (     2014 sectors,      1 MB)
> -# 2:      2048-     4095 (     2048 sectors,      1 MB)
> -# 3:      4096-     6143 (     2048 sectors,      1 MB)
> -# 4:      6144-     8191 (     2048 sectors,      1 MB)
> -# 5:      8192-    10239 (     2048 sectors,      1 MB)
> +NR START   END SECTORS  SIZE NAME            UUID
> + 1    34  2047    2014 1007K ThisIsName
> 1dcf10bc-637e-4c52-8203-087ae10a820b
> + 2  2048  4095    2048    1M ThisIsOtherName
> a1d03a96-7238-46c6-bbb3-789cbe173ec7
> + 3  4096  6143    2048    1M primary
> a7101b6c-468c-47df-aff6-cd444d12af61
> + 4  6144  8191    2048    1M primary
> afc4950a-f0f1-4add-802c-5957133486d1
> + 5  8192 10239    2048    1M primary
> 0db0a787-c16b-4886-af3a-fbb97299677c
> diff --git a/tests/expected/partx/partx-sgi b/tests/expected/partx/partx-sgi
> index 469d442..ba357e0 100644
> --- a/tests/expected/partx/partx-sgi
> +++ b/tests/expected/partx/partx-sgi
> @@ -1,2 +1,3 @@
> -# 1:        63-  1606499 (  1606437 sectors,    822 MB)
> -# 2:   1606500- 32129999 ( 30523500 sectors,  15628 MB)
> +NR   START      END  SECTORS   SIZE NAME UUID
> + 1      63  1606499  1606437 784.4M
> + 2 1606500 32129999 30523500  14.6G
> diff --git a/tests/expected/partx/partx-sun b/tests/expected/partx/partx-sun
> index d957f58..e69fdb1 100644
> --- a/tests/expected/partx/partx-sun
> +++ b/tests/expected/partx/partx-sun
> @@ -1,2 +1,3 @@
> -# 1:         0-    87379 (    87380 sectors,     44 MB)
> -# 2:     87380-   131069 (    43690 sectors,     22 MB)
> +NR START    END SECTORS  SIZE NAME UUID
> + 1     0  87379   87380 42.7M
> + 2 87380 131069   43690 21.3M
> diff --git a/tests/ts/look/separator b/tests/ts/look/separator
> index 17d68db..51e96c9 100755
> --- a/tests/ts/look/separator
> +++ b/tests/ts/look/separator
> @@ -34,8 +34,6 @@ TS_DESC="separator"
>  . $TS_TOPDIR/functions.sh
>  ts_init "$*"
> 
> -[ -f "/usr/share/dict/words" ] || ts_skip "/usr/share/dict/words not such file"
> -
> -$TS_CMD_LOOK apple-pie >> $TS_OUTPUT
> +$TS_CMD_LOOK apple-pie $TS_TOPDIR/ts/look/words >> $TS_OUTPUT
>  ts_finalize
> 
> diff --git a/tests/ts/look/words b/tests/ts/look/words
> new file mode 100644
> index 0000000..b67ba9a
> --- /dev/null
> +++ b/tests/ts/look/words
> @@ -0,0 +1,3 @@
> +apple
> +apple-pie
> +oranges
> 


