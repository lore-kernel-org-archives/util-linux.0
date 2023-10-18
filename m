Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5731CCDB474
	for <util-linux@archiver.kernel.org>; Wed, 18 Oct 2023 01:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjJRBEp (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 17 Oct 2023 21:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJRBEo (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 17 Oct 2023 21:04:44 -0400
X-Greylist: delayed 433 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 17 Oct 2023 18:04:42 PDT
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA3992
        for <util-linux@vger.kernel.org>; Tue, 17 Oct 2023 18:04:41 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1697590643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=svvgO/SeHMOdv2fcYn+8AJgEIltN25jWYovnI/wYWTE=;
        b=LBIDrpmrOrHzI4keaotvKCQ5sJszMMX9SnQhfm84Ar9OLkLbuPiS2HlArGPhU/tq/efK3c
        kbq5+TSWFYCoCREOAOUCIN88b6schs+uf+3f8EL2FhLQTKBjIPog3J8xbZylpCya/oE8eI
        BYzbvar8vyerYnmVaE8AOG2mxBo93e9yNPzs86xz/I8Pe4OkB/RS3qp4Vf3OmOIiyqrap0
        JN4VdEiNr08Jpt+XaBHKuW/kUs2jy5OZgpXdqkPLzRzIEqDM/ntxVg2HOumBvgNjsCYgmo
        nj2DWOuMSey+n6C7dC80YxpGpeUGOPXiOqi8Z9SO5TD7CTPBCTpGP18ZcGYIBQ==
Date:   Wed, 18 Oct 2023 02:57:23 +0200
From:   Dragan Simic <dsimic@manjaro.org>
To:     junxiao.bi@oracle.com
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] loopdev: fix losetup failure with a lost device file
In-Reply-To: <1457484d-5d28-47c2-b5b5-94f8b016023d@oracle.com>
References: <20231012215524.44326-1-junxiao.bi@oracle.com>
 <1457484d-5d28-47c2-b5b5-94f8b016023d@oracle.com>
Message-ID: <d6455a28d6b82bb1a1cafb2af101c7c8@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 2023-10-18 01:06, junxiao.bi@oracle.com wrote:
> Anybody can help take a look at this patch?

As a note, AFAIK it usually takes 7 to 10 days for the submitted patches 
to be reviewed.


> On 10/12/23 2:55 PM, Junxiao Bi wrote:
>> If a /dev/loopX is lost because someone might have removed it by 
>> mistake,
>> future losetup operations on that loop device will fail.
>> For examples, following cmds will fail when loop device file is lost.
>> - "losetup -d $loop_device"
>> - "losetup -f $file" or "mount $file $dev"
>> 
>> Users can resurrect the loop device by recreating the device using 
>> mknod,
>> but regular users might not be aware. Since /sysfs still have the loop
>> device intact, this commit will detect that case by scanning sysfs and
>> recreate the lost device file.
>> 
>> Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
>> ---
>>   lib/loopdev.c       | 100 
>> ++++++++++++++++++++++++++++++++++++++++----
>>   sys-utils/losetup.c |  14 +++----
>>   2 files changed, 97 insertions(+), 17 deletions(-)
>> 
>> diff --git a/lib/loopdev.c b/lib/loopdev.c
>> index dae499f256fa..4fc617830bae 100644
>> --- a/lib/loopdev.c
>> +++ b/lib/loopdev.c
>> @@ -279,6 +279,87 @@ static struct path_cxt *loopcxt_get_sysfs(struct 
>> loopdev_cxt *lc)
>>   	return lc->sysfs;
>>   }
>>   +static int loopcxt_get_devid(struct loopdev_cxt *lc)
>> +{
>> +	int devid = -1;
>> +	const char *p, *dev = loopcxt_get_device(lc);
>> +
>> +	if (!dev)
>> +		return -EINVAL;
>> +
>> +	p = strrchr(dev, '/');
>> +	if (!p || (sscanf(p, "/loop%d", &devid) != 1
>> +				&& sscanf(p, "/%d", &devid) != 1))
>> +		return -EINVAL;
>> +
>> +	return devid;
>> +}
>> +
>> +/* scan sysfs entry for loop device. */
>> +static int loopcxt_scan_sysfs(struct loopdev_cxt *lc)
>> +{
>> +	struct dirent *d;
>> +	DIR *sysblock;
>> +	int nr;
>> +	char name[256];
>> +
>> +	if (!loopcxt_sysfs_available(lc))
>> +		return 0;
>> +
>> +	sysblock = opendir(_PATH_SYS_BLOCK);
>> +	if (!sysblock)
>> +		return 0;
>> +
>> +	nr = loopcxt_get_devid(lc);
>> +	sprintf(name, "loop%d", nr);
>> +
>> +	while ((d = readdir(sysblock))) {
>> +		if (!strcmp(d->d_name, name))
>> +			return 1;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * losetup cmds could fail if /dev/loopX is removed by mistake.
>> + * This function will try to detect whether that is case,
>> + * if so, it will recreate the device file and open it.
>> + * Return fd if succeed, otherwise negative error code.
>> + */
>> +static int loopcxt_fix_lost_device_file(struct loopdev_cxt *lc)
>> +{
>> +	char path[PATH_MAX];
>> +	int nr, ret;
>> +	FILE *fp;
>> +	unsigned int major, minor;
>> +
>> +	if (!loopcxt_scan_sysfs(lc))
>> +		return -1;
>> +
>> +	nr = loopcxt_get_devid(lc);
>> +	if (nr < 0)
>> +		return -1;
>> +	ret = snprintf(path, PATH_MAX, "%s/loop%d/dev",
>> +			_PATH_SYS_BLOCK, nr);
>> +	if (ret <= 0 || ret >= PATH_MAX)
>> +		return -1;
>> +	fp = fopen(path, "r");
>> +	if (!fp)
>> +		return -1;
>> +	ret = fscanf(fp, "%d:%d", &major, &minor);
>> +	fclose(fp);
>> +	if (ret != 2)
>> +		return -1;
>> +	sprintf(path, "/dev/loop%d", nr);
>> +	/* default loop device permission is "brw-rw----" */
>> +	umask(0003);
>> +	ret = mknod(path, S_IFBLK|0660, makedev(major, minor));
>> +	if (ret)
>> +		return -1;
>> +	return open(path, lc->mode | O_CLOEXEC);
>> +}
>> +
>>   static int __loopcxt_get_fd(struct loopdev_cxt *lc, mode_t mode)
>>   {
>>   	int old = -1;
>> @@ -303,7 +384,17 @@ static int __loopcxt_get_fd(struct loopdev_cxt 
>> *lc, mode_t mode)
>>   		DBG(CXT, ul_debugobj(lc, "open %s [%s]: %m", lc->device,
>>   				mode == O_RDONLY ? "ro" :
>>   			        mode == O_RDWR ? "rw" : "??"));
>> -
>> +		/* loop device file not exist. */
>> +		if (lc->fd < 0 && errno == ENOENT) {
>> +			lc->fd = loopcxt_fix_lost_device_file(lc);
>> +			DBG(CXT, ul_debugobj(lc, "recreate %s fd %d",
>> +						lc->device, lc->fd));
>> +			/* loop file is not lost but doesn't exist,
>> +			 * reset errno to have user know.
>> +			 */
>> +			if (lc->fd < 0)
>> +				errno = ENOENT;
>> +		}
>>   		if (lc->fd < 0 && old >= 0) {
>>   			/* restore original on error */
>>   			lc->fd = old;
>> @@ -416,13 +507,6 @@ static int loopiter_set_device(struct loopdev_cxt 
>> *lc, const char *device)
>>   	    !(lc->iter.flags & LOOPITER_FL_FREE))
>>   		return 0;	/* caller does not care about device status */
>>   -	if (!is_loopdev(lc->device)) {
>> -		DBG(ITER, ul_debugobj(&lc->iter, "%s does not exist", lc->device));
>> -		return -errno;
>> -	}
>> -
>> -	DBG(ITER, ul_debugobj(&lc->iter, "%s exist", lc->device));
>> -
>>   	used = loopcxt_get_offset(lc, NULL) == 0;
>>     	if ((lc->iter.flags & LOOPITER_FL_USED) && used)
>> diff --git a/sys-utils/losetup.c b/sys-utils/losetup.c
>> index 0ca910ae3347..b45cc2ee8f3c 100644
>> --- a/sys-utils/losetup.c
>> +++ b/sys-utils/losetup.c
>> @@ -653,7 +653,7 @@ static int create_loop(struct loopdev_cxt *lc,
>>   		}
>>     		/* errors */
>> -		errpre = hasdev && loopcxt_get_fd(lc) < 0 ?
>> +		errpre = hasdev && lc->fd < 0 ?
>>   				 loopcxt_get_device(lc) : file;
>>   		warn(_("%s: failed to set up loop device"), errpre);
>>   		break;
>> @@ -741,8 +741,7 @@ int main(int argc, char **argv)
>>   			break;
>>   		case 'c':
>>   			act = A_SET_CAPACITY;
>> -			if (!is_loopdev(optarg) ||
>> -			    loopcxt_set_device(&lc, optarg))
>> +			if (loopcxt_set_device(&lc, optarg))
>>   				err(EXIT_FAILURE, _("%s: failed to use device"),
>>   						optarg);
>>   			break;
>> @@ -754,8 +753,7 @@ int main(int argc, char **argv)
>>   			break;
>>   		case 'd':
>>   			act = A_DELETE;
>> -			if (!is_loopdev(optarg) ||
>> -			    loopcxt_set_device(&lc, optarg))
>> +			if (loopcxt_set_device(&lc, optarg))
>>   				err(EXIT_FAILURE, _("%s: failed to use device"),
>>   						optarg);
>>   			break;
>> @@ -883,8 +881,7 @@ int main(int argc, char **argv)
>>   		else
>>   			act = A_SHOW_ONE;
>>   -		if (!is_loopdev(argv[optind]) ||
>> -		    loopcxt_set_device(&lc, argv[optind]))
>> +		if (loopcxt_set_device(&lc, argv[optind]))
>>   			err(EXIT_FAILURE, _("%s: failed to use device"),
>>   					argv[optind]);
>>   		optind++;
>> @@ -935,8 +932,7 @@ int main(int argc, char **argv)
>>   	case A_DELETE:
>>   		res = delete_loop(&lc);
>>   		while (optind < argc) {
>> -			if (!is_loopdev(argv[optind]) ||
>> -			    loopcxt_set_device(&lc, argv[optind]))
>> +			if (loopcxt_set_device(&lc, argv[optind]))
>>   				warn(_("%s: failed to use device"),
>>   						argv[optind]);
>>   			optind++;
