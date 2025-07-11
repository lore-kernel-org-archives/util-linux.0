Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717451EEF9
	for <util-linux@vger.kernel.org>; Fri, 11 Jul 2025 22:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752272578; cv=none; b=nXN4NZALraUlqmYgoPjnxYUHITiGfY2tJ0qXlKLPafixQFK8RmOjX8B7scyofXhYxRTXtuRonM5G0hhiN/6Tz8XMEPUijb/XtrL+r+504m6vCC6EbskZg3MbjG51YaY10v4GlTGWumkORJY0LMCMI/yxv452sB3odEUpAyu164E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752272578; c=relaxed/simple;
	bh=jLIUcF2JzEzVVdNYmttke8QT/+wFN4QpX/EwIsNIkYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iU8KKYugbs8rOT7WWOtbaBV3Y+lJTQfo5jCJQu1EiJu8ItqypIki3FTNHW7MUJ3uyeU24uVwOm51W1nEu+qRLzZGjrcli3V0ZWJBk10W9B+bQPjGpMMnCyKmRK2ooSQbQYuwPwhPy9Xn91kgp20Ex4+kkeXyg78knCDGx+n/Cho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0ECE216F2;
	Fri, 11 Jul 2025 15:22:45 -0700 (PDT)
Received: from [192.168.20.57] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D47033F694;
	Fri, 11 Jul 2025 15:22:54 -0700 (PDT)
Message-ID: <935fd521-508a-4f66-9ece-7ccf2eea61b9@arm.com>
Date: Fri, 11 Jul 2025 17:22:44 -0500
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] lscpu-arm: Allow externally sourced model name.
To: Paul Benoit <paul@os.amperecomputing.com>, util-linux@vger.kernel.org
References: <20250711211648.53361-1-paul@os.amperecomputing.com>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <20250711211648.53361-1-paul@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 7/11/25 4:16 PM, Paul Benoit wrote:
> When there isn't an entry for the model name in the id_part table(s),
> attempt to get the machine name from /sys/bus/soc/devices/soc0/machine
> to use as the model name.  This mechanism allows lscpu to use the
> model/machine name provided via the ARM SMC support code rather than via
> hard-coded lscpu tables.

Since this is suppose to be synced with the DMI data, and is sourced 
from the firmware would it make more sense to replace the BIOS name with it?


> 
> This code was tested by removing the "Ampere-1a" entry from the
> ampere-part table and verifying that lscpu displayed the correct machine
> name obtained via the ARM SMC interface to Trusted Firmware.  The
> "Ampere-1a" entry will be permanently removed by a separate patch.
> 
> Signed-off-by: Paul Benoit <paul@os.amperecomputing.com>
> ---
>   sys-utils/lscpu-arm.c | 35 ++++++++++++++++++++++++++++++++---
>   sys-utils/lscpu.h     |  1 +
>   2 files changed, 33 insertions(+), 3 deletions(-)
> 
> diff --git a/sys-utils/lscpu-arm.c b/sys-utils/lscpu-arm.c
> index 8745599d4..a46106bcb 100644
> --- a/sys-utils/lscpu-arm.c
> +++ b/sys-utils/lscpu-arm.c
> @@ -388,7 +388,10 @@ int is_arm(struct lscpu_cxt *cxt)
>   static int arm_ids_decode(struct lscpu_cputype *ct)
>   {
>   	int impl, part, j;
> +	unsigned int i;
>   	const struct id_part *parts = NULL;
> +	FILE *fd;
> +	char machinename[BUFSIZ] = "";
>   
>   	impl = parse_implementer_id(ct);
>   	if (impl <= 0)
> @@ -406,11 +409,11 @@ static int arm_ids_decode(struct lscpu_cputype *ct)
>   
>   	/* decode model */
>   	if (!parts)
> -		goto done;
> +		goto try_machinename;
>   
>   	part = parse_model_id(ct);
>   	if (part <= 0)
> -		goto done;
> +		goto try_machinename;
>   
>   	for (j = 0; parts[j].id != -1; j++) {
>   		if (parts[j].id == part) {
> @@ -419,7 +422,33 @@ static int arm_ids_decode(struct lscpu_cputype *ct)
>   			break;
>   		}
>   	}
> -done:
> +
> +try_machinename:
> +
> +	/*
> +	 * If the Model name was not found in the lscpu 'id_part' tables, see
> +	 * if there is a Machine name associated with the SOC.  This name may
> +	 * have been set via either SOC specific support code, or obtained
> +	 * via an ARM SMC CC call into Trusted Firmware.
> +	 */
> +	if (!ct->modelname) {
> +		fd = ul_path_fopen(NULL, "r", _PATH_SOC_MACHINENAME);
> +		if (fd) {
> +			if (!fgets(machinename, sizeof(machinename), fd))
> +				machinename[0] = '\0';
> +			fclose(fd);
> +
> +			/* Replace newline with string terminator */
> +			for (i = 0; i < strlen(machinename); i++) {
> +				if (machinename[i] == '\n')
> +					machinename[i] = '\0';
> +			}
> +
> +			if (strnlen(machinename, sizeof(machinename)))
> +				ct->modelname = xstrdup(machinename);
> +		}
> +	}
> +
>   	return 0;
>   }
>   
> diff --git a/sys-utils/lscpu.h b/sys-utils/lscpu.h
> index bd7b64cc5..581602f70 100644
> --- a/sys-utils/lscpu.h
> +++ b/sys-utils/lscpu.h
> @@ -46,6 +46,7 @@ UL_DEBUG_DECLARE_MASK(lscpu);
>   #define _PATH_SYS_NODE		_PATH_SYS_SYSTEM "/node"
>   #define _PATH_SYS_DMI		"/sys/firmware/dmi/tables/DMI"
>   #define _PATH_ACPI_PPTT		"/sys/firmware/acpi/tables/PPTT"
> +#define _PATH_SOC_MACHINENAME	"/sys/bus/soc/devices/soc0/machine"
>   
>   struct lscpu_cache {
>   	int		id;		/* unique identifier */

