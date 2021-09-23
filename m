Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447B9C433EF
	for <util-linux@archiver.kernel.org>; Thu, 23 Sep 2021 02:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C43060F0F
	for <util-linux@archiver.kernel.org>; Thu, 23 Sep 2021 02:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238875AbhIWCWe (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 22 Sep 2021 22:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238859AbhIWCWd (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 22 Sep 2021 22:22:33 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F409EC061574
        for <util-linux@vger.kernel.org>; Wed, 22 Sep 2021 19:21:02 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id w11so2990734plz.13
        for <util-linux@vger.kernel.org>; Wed, 22 Sep 2021 19:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UD7qkg3qTp7Y8K1m2drSatByZDw7CT7kIvw8vBs269I=;
        b=UyFL6haqVIXcAyOO2/z3Tb2MVg2MNSObG1Q93w7kiQiJePICkEu6WvCcmfj5yQ+La+
         NipH+npQbd0On+K+Heocn5OK7TaS8GItiCFPH9HLWSQHkcs+jGH89Vdez/6NuaFdRv5K
         xMRX4ai/7FnmsDadf9GcjWZpCXePNiVwWdhmJmsAOJIvwWjp9wCOhMduboGwYDXR1zke
         CPQRG+3SuOqcBiwPPquZVDOK/FqxhLd1IfJDTcOBTnowe9BS5UKPI/6mP4dFReLKrSmH
         GZl/Opnc24m4QcTjTC/YhfqpP7U1nQ9xKDfXxT8IekcgstmTYiRITPYcJhoVkLQRcl+8
         w0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UD7qkg3qTp7Y8K1m2drSatByZDw7CT7kIvw8vBs269I=;
        b=KsjZ8CDw0gAw1IjyjkrFwBkxun75NVxry464SLWcN50LL79SWyhq2N5Ie/mZLSn/hr
         vhJCDM3FC2++4zCgL3P3VzZBavRoxqt4HX3U7gnznYvOf+sOJGuAoOGkJDoiRAI0rgZU
         VyC4egBZGlsdlpY0zmyQb1j0BaAcMb9S3TyjPYoPgr7SC3snmWwYVDR2tZ5ynbF1jjuy
         uNNJuGk8a64kXr/oHnxps4pZ25JLMAlXvYHa5/OMzdmXo75RwMa9bLTrqMbOGKCcxvOo
         80imaoysUgm7bPRRdwErGn3hAKTfmhRuV7XbMoAz75Jw9RtbdRoJk/F2X3Xm1KTGoVae
         BjeA==
X-Gm-Message-State: AOAM533qCwUvGx9yuxS3uof13bJYN4jEWTPeIWYujLo6uhhJq8kKAsD/
        TykvuE+p8vaUuC4HvaRnFycfBWMyuU8m4Q==
X-Google-Smtp-Source: ABdhPJxGuDHJkLAq2azAYSF9TG2Rnvg2G7jbLBXgkVsJIJ+yCmPNeNSE3hyV66166Oe00dS2f4ElFA==
X-Received: by 2002:a17:90a:11:: with SMTP id 17mr2507590pja.238.1632363662225;
        Wed, 22 Sep 2021 19:21:02 -0700 (PDT)
Received: from [10.2.24.177] ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id t15sm4250811pgi.80.2021.09.22.19.20.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 19:21:00 -0700 (PDT)
Subject: PING: [PATCH] blkpr: add block persistent reservations command
To:     kzak@redhat.com
Cc:     util-linux@vger.kernel.org
References: <20210916032901.2189336-1-pizhenwei@bytedance.com>
From:   zhenwei pi <pizhenwei@bytedance.com>
Message-ID: <add3080a-8fcf-134b-764f-52a04db0f4b4@bytedance.com>
Date:   Thu, 23 Sep 2021 10:18:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210916032901.2189336-1-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


PING!

On 9/16/21 11:29 AM, zhenwei pi wrote:
> Linux kernel block layer supports PR (persistent reservations) ioctl
> on a block device. Typically SCSI and NVMe disk support PR feature,
> and blkpr could operation on them.
> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>   configure.ac            |  11 ++
>   sys-utils/Makemodule.am |   8 ++
>   sys-utils/blkpr.8.adoc  |  64 ++++++++++
>   sys-utils/blkpr.c       | 277 ++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 360 insertions(+)
>   create mode 100644 sys-utils/blkpr.8.adoc
>   create mode 100644 sys-utils/blkpr.c
> 
> diff --git a/configure.ac b/configure.ac
> index 60e63592b..ae47a5c6c 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -310,6 +310,7 @@ AC_CHECK_HEADERS([ \
>   	linux/fiemap.h \
>   	linux/net_namespace.h \
>   	linux/nsfs.h \
> +	linux/pr.h \
>   	linux/raw.h \
>   	linux/securebits.h \
>   	linux/tiocl.h \
> @@ -387,6 +388,10 @@ AC_CHECK_DECLS([BLK_ZONE_REP_CAPACITY], [], [], [
>   	#include <linux/blkzoned.h>
>   ])
>   
> +AC_CHECK_DECLS([PR_REP_CAPACITY], [], [], [
> +	#include <linux/pr.h>
> +])
> +
>   AC_CHECK_HEADERS([security/openpam.h], [], [], [
>   #ifdef HAVE_SECURITY_PAM_APPL_H
>   #include <security/pam_appl.h>
> @@ -454,6 +459,7 @@ dnl
>   have_linux_blkzoned_h=$ac_cv_header_linux_blkzoned_h
>   have_linux_btrfs_h=$ac_cv_header_linux_btrfs_h
>   have_linux_capability_h=$ac_cv_header_linux_capability_h
> +have_linux_pr_h=$ac_cv_header_linux_pr_h
>   have_linux_raw_h=$ac_cv_header_linux_raw_h
>   have_linux_securebits_h=$ac_cv_header_linux_securebits_h
>   have_linux_version_h=$ac_cv_header_linux_version_h
> @@ -1905,6 +1911,11 @@ UL_REQUIRES_LINUX([blkzone])
>   UL_REQUIRES_HAVE([blkzone], [linux_blkzoned_h], [linux/blkzoned.h header])
>   AM_CONDITIONAL([BUILD_BLKZONE], [test "x$build_blkzone" = xyes])
>   
> +UL_BUILD_INIT([blkpr], [check])
> +UL_REQUIRES_LINUX([blkpr])
> +UL_REQUIRES_HAVE([blkpr], [linux_pr_h], [linux/pr.h header])
> +AM_CONDITIONAL([BUILD_BLKPR], [test "x$build_blkpr" = xyes])
> +
>   UL_BUILD_INIT([ldattach], [check])
>   UL_REQUIRES_LINUX([ldattach])
>   AM_CONDITIONAL([BUILD_LDATTACH], [test "x$build_ldattach" = xyes])
> diff --git a/sys-utils/Makemodule.am b/sys-utils/Makemodule.am
> index e55363484..22047d9bd 100644
> --- a/sys-utils/Makemodule.am
> +++ b/sys-utils/Makemodule.am
> @@ -202,6 +202,14 @@ blkzone_SOURCES = sys-utils/blkzone.c
>   blkzone_LDADD = $(LDADD) libcommon.la
>   endif
>   
> +if BUILD_BLKPR
> +sbin_PROGRAMS += blkpr
> +MANPAGES += sys-utils/blkpr.8
> +dist_noinst_DATA += sys-utils/blkpr.8.adoc
> +blkpr_SOURCES = sys-utils/blkpr.c
> +blkpr_LDADD = $(LDADD) libcommon.la
> +endif
> +
>   if BUILD_LDATTACH
>   usrsbin_exec_PROGRAMS += ldattach
>   MANPAGES += sys-utils/ldattach.8
> diff --git a/sys-utils/blkpr.8.adoc b/sys-utils/blkpr.8.adoc
> new file mode 100644
> index 000000000..dc8bb3893
> --- /dev/null
> +++ b/sys-utils/blkpr.8.adoc
> @@ -0,0 +1,64 @@
> +//po4a: entry man manual
> += blkpr(8)
> +:doctype: manpage
> +:man manual: System Administration
> +:man source: util-linux {release-version}
> +:page-layout: base
> +:command: blkpr
> +
> +== NAME
> +
> +blkpr - run persistent reservations command on a device
> +
> +== SYNOPSIS
> +
> +*blkpr* [options] _device_
> +
> +== DESCRIPTION
> +
> +*blkpr* is used to run persistent reservations command on device that supports Persistent Reservations feature.
> +
> +The _device_ argument is the pathname of the block device.
> +
> +== OPTIONS
> +
> +*-o*, *--operation* _operation_::
> +The operation of persistent reservations, supported [register|reserve|release|preempt|preempt-abort|clear].
> +
> +*-k*, *--key* _key_::
> +The key the operation should operate on.
> +
> +*-K*, *--oldkey* _oldkey_::
> +The old key the operation should operate on.
> +
> +*-f*, *--flag* _flag_::
> +Supported flag [ignore-key].
> +
> +*-t*, *--type*::
> +Supported type [write-exclusive|exclusive-access|write-exclusive-reg-only|exclusive-access-reg-only|write-exclusive-all-regs|exclusive-access-all-regs]
> +
> +*-V*, *--version*::
> +Display version information and exit.
> +
> +*-h*, *--help*::
> +Display help text and exit.
> +
> +== AUTHORS
> +
> +mailto:pizhenwei@bytedance.com[zhenwei pi]
> +
> +== SEE ALSO
> +
> +*sg_persist*(8)
> +
> +Linux documentation at: <https://www.kernel.org/doc/Documentation/block/pr.txt>
> +iSCSI specification at: <https://datatracker.ietf.org/doc/html/rfc3720>
> +NVMe-oF specification at: <https://nvmexpress.org/nvme-over-fabrics-part-two/>
> +
> +include::man-common/bugreports.adoc[]
> +
> +include::man-common/footer.adoc[]
> +
> +ifdef::translation[]
> +include::man-common/translation.adoc[]
> +endif::[]
> diff --git a/sys-utils/blkpr.c b/sys-utils/blkpr.c
> new file mode 100644
> index 000000000..3f8c19343
> --- /dev/null
> +++ b/sys-utils/blkpr.c
> @@ -0,0 +1,277 @@
> +/*
> + * blkpr.c -- persistent reservations on a block device.
> + *
> + * Copyright (C) 2021 zhenwei pi <pizhenwei@bytedance.com>
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + *
> + * This program uses IOC_PR_XXX ioctl to do persistent reservations
> + * operation on a block device if the device supports it.
> + */
> +
> +
> +#include <string.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <getopt.h>
> +#include <locale.h>
> +#include <sys/ioctl.h>
> +#include <linux/pr.h>
> +
> +#include "nls.h"
> +#include "c.h"
> +#include "closestream.h"
> +#include "strutils.h"
> +#include "xalloc.h"
> +
> +struct type_string {
> +	int type;
> +	char *str;
> +};
> +
> +/* This array should keep align with enum pr_type of linux/types.h */
> +static struct type_string pr_type[] = {
> +	{PR_WRITE_EXCLUSIVE,           "write-exclusive"},
> +	{PR_EXCLUSIVE_ACCESS,          "exclusive-access"},
> +	{PR_WRITE_EXCLUSIVE_REG_ONLY,  "write-exclusive-reg-only"},
> +	{PR_EXCLUSIVE_ACCESS_REG_ONLY, "exclusive-access-reg-only"},
> +	{PR_WRITE_EXCLUSIVE_ALL_REGS,  "write-exclusive-all-regs"},
> +	{PR_EXCLUSIVE_ACCESS_ALL_REGS, "exclusive-access-all-regs"}
> +};
> +
> +static struct type_string pr_operation[] = {
> +	{IOC_PR_REGISTER,      "register"},
> +	{IOC_PR_RESERVE,       "reserve"},
> +	{IOC_PR_RELEASE,       "release"},
> +	{IOC_PR_PREEMPT,       "preempt"},
> +	{IOC_PR_PREEMPT_ABORT, "preempt-abort"},
> +	{IOC_PR_CLEAR,         "clear"},
> +};
> +
> +static struct type_string pr_flag[] = {
> +	{PR_FL_IGNORE_KEY, "ignore-key"}
> +};
> +
> +static char *all_type_string(struct type_string *ts, int nmem)
> +{
> +	char *prtypes, *tmp;
> +	size_t total = 0, length;
> +	int i;
> +
> +	for (i = 0; i < nmem; i++) {
> +		total += (strlen(ts[i].str) + 1);
> +	}
> +
> +	tmp = prtypes = xmalloc(total);
> +	for (i = 0; i < nmem; i++) {
> +		strcpy(tmp, ts[i].str);
> +		length = strlen(ts[i].str);
> +
> +		tmp[length++] = '|';
> +		tmp += length;
> +	}
> +
> +	/* strip the last '|' */
> +	prtypes[total - 1] = '\0';
> +
> +	return prtypes;
> +}
> +
> +static int parse_type_by_str(struct type_string *ts, int nmem, char *pattern)
> +{
> +	int i;
> +
> +	for (i = 0; i < nmem; i++) {
> +		if (!strcmp(ts[i].str, pattern)) {
> +			return ts[i].type;
> +		}
> +	}
> +
> +	return -1;
> +}
> +
> +#define SUPPORTED(XX) \
> +	static char *supported_##XX(void) \
> +	{ return all_type_string(XX, ARRAY_SIZE(XX)); }
> +
> +#define PARSE(XX) \
> +	static int parse_##XX(char *pattern) \
> +	{ return parse_type_by_str(XX, ARRAY_SIZE(XX), pattern); }
> +
> +SUPPORTED(pr_type);
> +SUPPORTED(pr_operation);
> +SUPPORTED(pr_flag);
> +
> +PARSE(pr_type);
> +PARSE(pr_operation);
> +PARSE(pr_flag);
> +
> +static int do_pr(char *path, uint64_t key, uint64_t oldkey, int op, int type, int flag)
> +{
> +	struct pr_registration pr_reg;
> +	struct pr_reservation pr_res;
> +	struct pr_preempt pr_prt;
> +	struct pr_clear pr_clr;
> +	int fd, ret;
> +
> +	fd = open(path, O_RDWR);
> +	if (fd < 0) {
> +		err(EXIT_FAILURE, _("cannot open %s"), path);
> +	}
> +
> +	switch (op) {
> +	case IOC_PR_REGISTER:
> +		pr_reg.old_key = oldkey;
> +		pr_reg.new_key = key;
> +		pr_reg.flags = flag;
> +		ret = ioctl(fd, op, &pr_reg);
> +		break;
> +	case IOC_PR_RESERVE:
> +	case IOC_PR_RELEASE:
> +		pr_res.key = key;
> +		pr_res.type = type;
> +		pr_res.flags = flag;
> +		ret = ioctl(fd, op, &pr_res);
> +		break;
> +	case IOC_PR_PREEMPT:
> +	case IOC_PR_PREEMPT_ABORT:
> +		pr_prt.old_key = oldkey;
> +		pr_prt.new_key = key;
> +		pr_prt.type = type;
> +		pr_prt.flags = flag;
> +		ret = ioctl(fd, op, &pr_prt);
> +		break;
> +	case IOC_PR_CLEAR:
> +		pr_clr.key = key;
> +		pr_clr.flags = flag;
> +		ret = ioctl(fd, op, &pr_clr);
> +		break;
> +	default:
> +		errno = EINVAL;
> +		err(EXIT_FAILURE, _("unknown operation"));
> +	}
> +
> +	close(fd);
> +	if (ret < 0) {
> +		err(EXIT_FAILURE, _("pr ioctl failed"));
> +	} else if (ret > 0) {
> +		errx(EXIT_FAILURE, _("error code 0x%x, for more detailed information see specification of device model."), ret);
> +	}
> +
> +	return ret;
> +}
> +
> +static void __attribute__((__noreturn__)) usage(void)
> +{
> +	FILE *out = stdout;
> +	fputs(USAGE_HEADER, out);
> +	fprintf(out,
> +	      _(" %s [options] <device>\n"), program_invocation_short_name);
> +
> +	fputs(USAGE_SEPARATOR, out);
> +	fputs(_("Persistent reservations on a device.\n"), out);
> +
> +	fputs(USAGE_OPTIONS, out);
> +	fprintf(out, _(" -o, --operation <string>  supported operation [%s]\n"), supported_pr_operation());
> +	fputs(_(" -k, --key <num>           key to operate\n"), out);
> +	fputs(_(" -K, --oldkey <num>        old key to operate\n"), out);
> +	fprintf(out, _(" -f, --flag <string>       supported flag [%s]\n"), supported_pr_flag());
> +	fprintf(out, _(" -t, --type <string>       supported type [%s]\n"), supported_pr_type());
> +
> +	fputs(USAGE_SEPARATOR, out);
> +	printf(USAGE_HELP_OPTIONS(21));
> +
> +	fputs(USAGE_ARGUMENTS, out);
> +
> +	printf(USAGE_MAN_TAIL("blkpr(8)"));
> +	exit(EXIT_SUCCESS);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	char c;
> +	char *path;
> +	uint64_t key = 0, oldkey = 0;
> +	int operation = -1, type = -1, flag = 0;
> +
> +	static const struct option longopts[] = {
> +	    { "help",            no_argument,       NULL, 'h' },
> +	    { "version",         no_argument,       NULL, 'V' },
> +	    { "operation",       required_argument, NULL, 'o' },
> +	    { "key",             required_argument, NULL, 'k' },
> +	    { "oldkey",          required_argument, NULL, 'K' },
> +	    { "flag",            required_argument, NULL, 'f' },
> +	    { "type",            required_argument, NULL, 't' },
> +	    { NULL, 0, NULL, 0 }
> +	};
> +
> +	setlocale(LC_ALL, "");
> +	bindtextdomain(PACKAGE, LOCALEDIR);
> +	textdomain(PACKAGE);
> +	close_stdout_atexit();
> +
> +	errno = EINVAL;
> +	while ((c = getopt_long(argc, argv, "hVo:k:K:f:t:", longopts, NULL)) != -1) {
> +		switch(c) {
> +		case 'k':
> +			key = strtosize_or_err(optarg,
> +					_("failed to parse key"));
> +			break;
> +		case 'K':
> +			oldkey = strtosize_or_err(optarg,
> +					_("failed to parse old key"));
> +			break;
> +		case 'o':
> +			operation = parse_pr_operation(optarg);
> +			if (operation < 0) {
> +				err(EXIT_FAILURE, _("unknown operation"));
> +			}
> +			break;
> +		case 't':
> +			type = parse_pr_type(optarg);
> +			if (type < 0) {
> +				err(EXIT_FAILURE, _("unknown type"));
> +			}
> +			break;
> +		case 'f':
> +			flag = parse_pr_flag(optarg);
> +			if (flag < 0) {
> +				err(EXIT_FAILURE, _("unknown flag"));
> +			}
> +			break;
> +
> +		case 'h':
> +			usage();
> +		case 'V':
> +			print_version(EXIT_SUCCESS);
> +		default:
> +			errtryhelp(EXIT_FAILURE);
> +		}
> +	}
> +
> +	if (optind == argc) {
> +		errx(EXIT_FAILURE, _("no device specified"));
> +	}
> +
> +	path = argv[optind++];
> +	if (optind != argc) {
> +		warnx(_("unexpected number of arguments"));
> +		errtryhelp(EXIT_FAILURE);
> +	}
> +
> +	do_pr(path, key, oldkey, operation, type, flag);
> +
> +	return EXIT_SUCCESS;
> +}
> 

-- 
zhenwei pi
