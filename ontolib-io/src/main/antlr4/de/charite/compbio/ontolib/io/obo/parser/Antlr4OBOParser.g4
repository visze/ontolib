/** ANTLR 4 grammar for the OBO v1.2 ontology description format.
 *
 * See <a href="http://owlcollab.github.io/oboformat/doc/GO.format.obo-1_2.html">The OBO Flat File
 * Format Specification, version 1.2 </a> for details.
 *
 * @author <a href="mailto:manuel.holtgrewe@bihealth.de">Manuel Holtgrewe</a>
 */
parser grammar Antlr4OBOParser;

options {
  tokenVocab = Antlr4OBOLexer;
} // use tokens from Antlr4OBOLexer

oboFile
:
  header eolComment+ stanzas
;

header
:
  headerKeyValue+
;

headerKeyValue
:
  keyValueFormatVersion
  | keyValueDataVersion
  | keyValueDate
  | keyValueSavedBy
  | keyValueAutoGeneratedBy
  | keyValueSubsetdef
  | keyValueImport
  | keyValueSynonymtypedef
  | keyValueIdspace
  | keyValueDefaultRelationshipIdPrefix
  | keyValueIdMapping
  | keyValueRemark
  | keyValueGeneric
;

eolComment
:
  Comment? EOL
;

stanzas
:
  stanza
  (
    eolComment+ stanza
  )* eolComment*
;

stanza
:
  termStanza
  | typedefStanza
  | instanceStanza
;

termStanza
:
  TermStanzaHeader eolComment termStanzaKeyValue+
;

termStanzaKeyValue
:
  keyValueID
  | keyValueName
  | keyValueIsAnonymous
  | keyValueAltID
  | keyValueDef
  | keyValueComment
  | keyValueSubset
  | keyValueSynonym
  | keyValueXRef
  | keyValueIsA
  | keyValueIntersectionOf
  | keyValueUnionOf
  | keyValueDisjointFrom
  | keyValueRelationship
  | keyValueIsObsolete
  | keyValueReplacedBy
  | keyValueConsider
  | keyValueCreatedBy
  | keyValueCreationDate
  | keyValueGeneric
;

typedefStanza
:
  TypedefStanzaHeader eolComment
;

typedefStanzaKeyValue
:
  keyValueID
  | keyValueName
  | keyValueIsAnonymous
  | keyValueAltID
  | keyValueDef
  | keyValueComment
  | keyValueSubset
  | keyValueSynonym
  | keyValueXRef
  | keyValueIsA
  | keyValueRelationship
  | keyValueIsObsolete
  | keyValueReplacedBy
  | keyValueConsider
  | keyValueCreatedBy
  | keyValueCreationDate
  | keyValueGeneric
  | keyValueDomain
  | keyValueRange
  | keyValueInverseOf
  | keyValueTransitiveOver
  | keyValueIsCyclic
  | keyValueIsReflexive
  | keyValueIsSymmetric
  | keyValueIsAntisymmetric
  | keyValueIsTransitive
  | keyValueIsMetadata
;

instanceStanza
:
  InstanceStanzaHeader eolComment
;

instanceStanzaKeyValue
:
  keyValueID
  | keyValueName
  | keyValueInstanceOf
  | keyValueIsAnonymous
  | keyValueAltID
  | keyValueComment
  | keyValueSynonym
  | keyValueXRef
  | keyValueIsObsolete
  | keyValueReplacedBy
  | keyValueGeneric
;

stringValue
:
  (
    ESC2
    | BooleanValue
    | SquareBraceOpen
    | CurlyBraceClose
    | SquareBraceOpen
    | SquareBraceClose
    | Equals
    | Comma
    | Semicolon
    | Space
    | Word
    | QuotedString
  )+
;

eolComment2
:
  Comment2? EOL2
;

keyValueID
:
  TagID ColonSpace stringValue
  (
    Space trailingModifier
  )? eolComment2
;

keyValueName
:
  TagName ColonSpace stringValue
  (
    Space trailingModifier
  )? eolComment2
;

keyValueIsAnonymous
:
  TagIsAnonymous ColonSpace BooleanValue
  (
    Space trailingModifier
  )? eolComment2
;

keyValueAltID
:
  TagAltID ColonSpace stringValue
  (
    Space trailingModifier
  )? eolComment2
;

keyValueDef
: // note the mandatory dbXRefList here
  TagDef ColonSpace QuotedString Space dbXRefList
  (
    Space trailingModifier
  )? eolComment2
;

keyValueComment
:
  TagComment ColonSpace stringValue
  (
    Space trailingModifier
  )? eolComment2
;

keyValueSubset
:
  TagSubset ColonSpace stringValue
  (
    Space trailingModifier
  )? eolComment2
;

keyValueSynonym
:
  TagSynonym ColonSpace QuotedString Space ScopeIdentifier
  (
    Space Word
  )?
  (
    Space dbXRefList
  )?
  (
    Space trailingModifier
  )? eolComment2
;

keyValueXRef
:
  TagXRef ColonSpace dbXRef
  (
    Space trailingModifier
  )? eolComment2
;

keyValueIsA
:
  TagIsA ColonSpace Word
  (
    Space trailingModifier
  )? eolComment2
;

keyValueIntersectionOf
:
  TagIntersectionOf ColonSpace
  (
    Word Space
  )? Word
  (
    Space trailingModifier
  )? eolComment2
;

keyValueUnionOf
:
  TagUnionOf ColonSpace Word
  (
    Space trailingModifier
  )? eolComment2
;

keyValueDisjointFrom
:
  TagDisjointFrom ColonSpace Word
  (
    Space trailingModifier
  )? eolComment2
;

keyValueRelationship
:
  TagRelationship ColonSpace
  (
    Word Space
  )? Word
  (
    Space trailingModifier
  )? eolComment2
;

keyValueIsObsolete
:
  TagIsObsolete ColonSpace BooleanValue
  (
    Space trailingModifier
  )? eolComment2
;

keyValueReplacedBy
:
  TagReplacedBy ColonSpace stringValue
  (
    Space trailingModifier
  )? eolComment2
;

keyValueConsider
:
  TagConsider ColonSpace stringValue
  (
    Space trailingModifier
  )? eolComment2
;

keyValueCreatedBy
:
  TagCreatedBy ColonSpace stringValue
  (
    Space trailingModifier
  )? eolComment2
;

keyValueCreationDate
:
  TagCreationDate ColonSpace stringValue
  (
    Space trailingModifier
  )? eolComment2
;

keyValueGeneric
:
  GenericStanzaTag ColonSpace stringValue
  (
    Space trailingModifier
  )? eolComment2
;

keyValueDomain
:
  TagDomain ColonSpace stringValue
  (
    Space trailingModifier
  )? eolComment2
;

keyValueRange
:
  TagRange ColonSpace stringValue
  (
    Space trailingModifier
  )? eolComment2
;

keyValueInverseOf
:
  TagInverseOf ColonSpace stringValue
  (
    Space trailingModifier
  )? eolComment2
;

keyValueTransitiveOver
:
  TagTransitiveOver ColonSpace stringValue
  (
    Space trailingModifier
  )? eolComment2
;

keyValueIsCyclic
:
  TagIsCyclic ColonSpace BooleanValue
  (
    Space trailingModifier
  )? eolComment2
;

keyValueIsReflexive
:
  TagIsReflexive ColonSpace BooleanValue
  (
    Space trailingModifier
  )? eolComment2
;

keyValueIsSymmetric
:
  TagIsSymmetric ColonSpace BooleanValue
  (
    Space trailingModifier
  )? eolComment2
;

keyValueIsAntisymmetric
:
  TagIsAntisymmetric ColonSpace BooleanValue
  (
    Space trailingModifier
  )? eolComment2
;

keyValueIsTransitive
:
  TagIsTransitive ColonSpace BooleanValue
  (
    Space trailingModifier
  )? eolComment2
;

keyValueIsMetadata
:
  TagIsMetadata ColonSpace BooleanValue
  (
    Space trailingModifier
  )? eolComment2
;

keyValueInstanceOf
:
  TagInstanceOf ColonSpace stringValue
  (
    Space trailingModifier
  )? eolComment2
;

keyValueFormatVersion
:
  TagFormatVersion ColonSpace stringValue
  (
    Space trailingModifier
  )? eolComment2
;

keyValueDataVersion
:
  TagDataVersion ColonSpace stringValue
  (
    Space trailingModifier
  )? eolComment2
;

keyValueDate
:
  TagDate ColonSpace stringValue
  (
    Space trailingModifier
  )? eolComment2
;

keyValueSavedBy
:
  TagSavedBy ColonSpace stringValue
  (
    Space trailingModifier
  )? eolComment2
;

keyValueAutoGeneratedBy
:
  TagAutoGeneratedBy ColonSpace stringValue
  (
    Space trailingModifier
  )? eolComment2
;

keyValueSubsetdef
:
  TagSubsetdef ColonSpace Word Space QuotedString
  (
    Space trailingModifier
  )? eolComment2
;

keyValueImport
:
  TagImport ColonSpace stringValue
  (
    Space trailingModifier
  )? eolComment2
;

keyValueSynonymtypedef
:
  TagSynonymtypedef ColonSpace Word Space QuotedString
  (
    Space ScopeIdentifier
  )?
  (
    Space trailingModifier
  )? eolComment2
;

keyValueIdspace
:
  TagIdspace ColonSpace Word Space Word Space QuotedString
  (
    Space trailingModifier
  )? eolComment2
;

keyValueDefaultRelationshipIdPrefix
:
  TagDefaultRelationshipIdPrefix ColonSpace Word
  (
    Space trailingModifier
  )? eolComment2
;

keyValueIdMapping
:
  TagIdMapping ColonSpace Word Space Word
  (
    Space trailingModifier
  )? eolComment2
;

keyValueRemark
:
  TagRemark ColonSpace stringValue
  (
    Space trailingModifier
  )? eolComment2
;

// Trailing modifier definition

trailingModifier
:
  CurlyBraceOpen
  (
    trailingModifierKeyValue
    (
      Comma Space* trailingModifierKeyValue
    )*
  )? CurlyBraceClose
;

trailingModifierKeyValue
:
  Word Equals
  (
    Word
    | QuotedString
  )
;

// dbxrefs

dbXRefList
:
  SquareBraceOpen
  (
    dbXRef
    (
      (
        Comma
        | Semicolon
      ) Space* dbXRef
    )*
  )? SquareBraceClose
;

dbXRef
:
  Word
  (
    Space QuotedString
  )?
  (
    Space trailingModifier
  )?
;