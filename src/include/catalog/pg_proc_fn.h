/*-------------------------------------------------------------------------
 *
 * pg_proc_fn.h
 * 	 prototypes for functions in catalog/pg_proc.c
 *
 *
 * Portions Copyright (c) 1996-2008, PostgreSQL Global Development Group
 * Portions Copyright (c) 1994, Regents of the University of California
 *
 * $PostgreSQL: pgsql/src/include/catalog/pg_proc_fn.h,v 1.4 2008/12/18 18:20:35 tgl Exp $
 *
 *-------------------------------------------------------------------------
 */
#ifndef PG_PROC_FN_H
#define PG_PROC_FN_H

#include "nodes/pg_list.h"

extern Oid ProcedureCreate(const char *procedureName,
				Oid procNamespace,
				bool replace,
				bool returnsSet,
				Oid returnType,
				Oid languageObjectId,
				Oid languageValidator,
				const char *prosrc,
				const char *probin,
				bool isAgg,
				bool security_definer,
				bool isStrict,
				char volatility,
				oidvector *parameterTypes,
				Datum allParameterTypes,
				Datum parameterModes,
				Datum parameterNames,
				List *parameterDefaults,
				Datum proconfig,
				float4 procost,
				float4 prorows);

extern bool function_parse_error_transpose(const char *prosrc);

#endif   /* PG_PROC_FN_H */
